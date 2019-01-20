%sifting algorithm
        function [siftee, index] = sift(g, base, deltas, us, j) %deltas - basic orbits, us - corresponding transversal sets
            h = g;
            m = length(base);
            broken = false;
            for i = j:m
                beta = find(h == base(i));
                if (~inlist(beta, deltas{1, i}))
                    siftee = h;
                    index = i - 1;
                    broken = true;
                    break;
                end
                ui = us{1, i};
                for k = 1:length(ui(:, 1))
                    if (find(ui(k, :) == base(i)) == beta)
                        h = mult(h, ginv(ui(k, :)));
                        break;
                    end
                end
            end
            if (~broken)
                siftee = h;
                index = m;
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
       
       %inverse of a given permutation
       function l2 = ginv(l1)
       l2 = zeros(1, length(l1));
       for i = 1:length(l1)
           l2(i) = find(l1 == i);
       end
       end
       
       function prod = mult(p1, p2)
       n = length(p1);
       prod = zeros(1, n);
       for i = 1:n
           prod(i) = p1(p2(i));
       end
       end



