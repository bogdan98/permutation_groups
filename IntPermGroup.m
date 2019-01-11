classdef IntPermGroup < replab.Monoid
    %describes a permutation group on integers
    %specialized implementation
    
    properties (SetAccess = protected)
        order;
        generators;
    end
    
    methods
        % generators g1, g2, etc. look like [1, 3, 4, 2]
        % input is like IntPermGroup(4, [g1; g2; ...])
        function obj = IntPermGroup(n, g)
            obj.order = n;
            obj.generators = g;
        end
        
        function a = ithGen(obj, i)
            a = obj.generators(i, :);
        end
       
        %returns the orbit of point k (1<=k<=n)
        function orb = orbit(obj, k)
            gens = obj.generators;
            n = obj.order;
            l = [];
            i = 1;
            while (i <= length(gens(:, 1)))
                tmp = find(gens(i, :) == k);
                if (inlist(tmp, l) == 0)
                    j = binins(tmp, l);
                    len = length(l);
                    if (j == 1)
                        l = [tmp, l];
                    else
                        l = [l(1:j-1), tmp, l(j:len)];
                    end
                end
                i = i + 1;
            end
            orb = l;
        end
    end
end
      
       %checks whether a point is in list, using binary search
       function k = inlist(el, list)
            left = 1;
            right = length(list);
            k = false; 
            while (left <= right)
                mid = ceil((right + left)/2);
                
                if (list(mid) == el)
                    k = true;
                    break;
                else
                    if (list(mid) > el)
                        right = mid - 1;
                    else
                        left = mid + 1;
                    end 
                end
            end
       end
       
       %returns the index where el, should be inserted in a sorted list
       function ind = binins(el, list)
       left = 1;
       right = length(list);
       mid = 0;
       if (isempty(list))
           ind = 1;
       else 
           while (left <= right)
               mid = ceil((left + right)/2);
               
               if (list(mid) == el)
                   ind = mid + 1;
                   break;
               else
                   if (list(mid) > el)
                       right = mid - 1;
                       ind = mid;
                   else
                       left = mid + 1;
                       ind = mid + 1;
                   end
               end
           end
       end
       end

       

            
       
