classdef IntPermGroup < replab.Monoid
    %describes a permutation group on integers
    %specialized implementation
    
    properties (SetAccess = protected)
        order;
        generators;
        stab_chain;
        base;
        transversal_set;
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
        
        %intermediate function for orbit calculation
        function [tr, orb] = orbit1(obj, k)
            gens = obj.generators;
            [tr, orb] = orbit(gens, k);
        end
            
        
        %sifting algorithm
           
    end
end
      
       %inverse of a given permutation
       function l2 = ginv(l1)
       l2 = zeros(1, length(l1));
       for i = 1:length(l1)
           l2(i) = find(l1 == i);
       end
       end
       
       %product of two permutations
       function prod = mult(p1, p2)
       n = length(p1);
       prod = zeros(1, n);
       for i = 1:n
           prod(i) = p1(p2(i));
       end
       end
       
       %function to calculate the orbit of a point
       %under given generators and transversal set
       %without use of Schreier trees
       function [trans, orb] = orbit(gens, k)
            l = [k];
            n = length(gens(1, :)); %order
            inlist = false(1, n); %is already in the list
            comefrom = zeros(1, n);
            us = zeros(n, n);
            for i = 1:n
                us(i,:) = 1:n;
            end
            while (~isempty(l))
                top = l(1);
                inlist(top) = true;
                cl = length(l); %pop the top value
                if (cl == 1)
                    l = [];
                else
                    l = l(2:cl);
                end
                
                for i = 1:length(gens(:, 1))
                    tmp = find(gens(i, :) == top);
                    if (~inlist(tmp))
                        comefrom(tmp) = top;
                        l = [tmp, l];
                        us(tmp, :) = gens(i, :);
                    end
                end
                
            end
            orb = [];
            for i = 1:n
                if (inlist(i))
                    orb = [orb, i];
                end
            end
            
            trans = zeros(length(orb), n);
            for i = 1:length(orb)
                trans(i, :) = 1:n;
            end
            for i = 1:length(orb)
                k = orb(i);
                while (comefrom(k) ~= 0)
                    tmp = mult(us(k, :), trans(i, :));
                    trans(i, :) = tmp;
                    k = comefrom(k);
                end
            end
            
       end
       
       
       

            
       
