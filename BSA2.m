
% Main programs

function [ bestX, fMin, bred, arquitec ] = BSA2( M, pop, dim, FQ, c1, c2, a1, a2,lb,ub )
% Display help
%Initialization

for i = 1 : pop
    x( i, : ) = round(lb + (ub - lb) .* rand( 1, dim )); 
    [fit( i ),red]= FitFunc1p( x( i, : ) ); 
    arqui(i).nn = red;
%  fprintf(errord,['Error:' num2str(fit(i)) ' Iteracion:' int2str(i) ' Individuos:' int2str(pop) ' Capas: ' int2str(x(i,1)) ' Neuronas capa 1: ' int2str(x(i,2))  ' Neuronas Capa 2: ' int2str(x(i,3)) '\n']); 
end
pFit = fit; % The individual's best fitness value
pX = x;     % The individual's best position corresponding to the pFit

[ fMin, bestIndex ] = min( fit );  % fMin denotes the global optimum
% bestX denotes the position corresponding to fMin
bestX  = x( bestIndex, : );   
% arqui(i).nn = red;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start the iteration.
%fprintf(errord,['\n----------------------------------------\n\n']);

 for iteration = 1 : M
     
    prob = rand( pop, 1 ) .* 0.2 + 0.8;%The probability of foraging for food
    
    if( mod( iteration, FQ ) ~= 0 )         
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Birds forage for food or keep vigilance
        sumPfit = sum( pFit );
        meanP = mean( pX );
        for i = 1 : pop
            if rand < prob(i)
                x( i, : ) = round( x( i, : ) + c1 * rand.*(bestX - x( i, : ))+ ...
                    c2 * rand.*( pX(i,:) - x( i, : ) ));
            else
                person = randiTabu( 1, pop, i, 1 );
                
                x( i, : ) = round( x( i, : ) + rand.*(meanP - x( i, : )) * a1 * ...
                    exp( -pFit(i)/( sumPfit + realmin) * pop ) + a2 * ...
                    ( rand*2 - 1) .* ( pX(person,:) - x( i, : ) ) * exp( ...
                    -(pFit(person) - pFit(i))/(abs( pFit(person)-pFit(i) )...
                    + realmin) * pFit(person)/(sumPfit + realmin) * pop )); 
            end
           
            x( i, : ) = Bounds( x( i, : ), lb, ub );  
            [fit( i ), red] = FitFunc1p( x( i, : ) );
              
        end
         %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        FL = rand( pop, 1 ) .* 0.4 + 0.5;    %The followed coefficient
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Divide the bird swarm into two parts: producers and scroungers.
        [ans, minIndex ] = min( pFit );
        [ans, maxIndex ] = max( pFit );
        choose = 0;
        if ( minIndex < 0.5*pop && maxIndex < 0.5*pop )
            choose = 1;
        end
        if ( minIndex > 0.5*pop && maxIndex < 0.5*pop )
            choose = 2;
        end
        if ( minIndex < 0.5*pop && maxIndex > 0.5*pop )
            choose = 3;
        end
        if ( minIndex > 0.5*pop && maxIndex > 0.5*pop )
            choose = 4;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if choose < 3
            for i = (pop/2+1) : pop
                i=round(i)
                x( i, : ) = x( i, : ) * ( 1 + randn );
                x( i, : ) = Bounds( x( i, : ), lb, ub );
                x=round(x);
                [fit( i ), red]= FitFunc1p( x( i, : ) );
            end
            if choose == 1 
                x( minIndex,: ) = x( minIndex,: ) * ( 1 + randn );
                x( minIndex, : ) = Bounds( x( minIndex, : ), lb, ub );
                x=round(x);
                [fit( minIndex ),red ]= FitFunc1p( x( minIndex, : ) );
            end
            for i = 1 : 0.5*pop
                if choose == 2 || minIndex ~= i
                    person = randi( [(0.5*pop+1), pop ], 1 );
                    x( i, : ) = x( i, : ) + (pX(person, :) - x( i, : )) * FL( i );
                    x=round(x);
                    [fit( i ), red ]= FitFunc1p( x( i, : ) );
                end
            end
        else
            for i = 1 : 0.5*pop
                x( i, : ) = x( i, : ) * ( 1 + randn );
                x( i, : ) = Bounds( x( i, : ), lb, ub );
                x=round(x);
                [fit( i ), red ]= FitFunc1p( x( i, : ) );
            end
            if choose == 4 
                x( minIndex,: ) = x( minIndex,: ) * ( 1 + randn );
                x( minIndex, : ) = Bounds( x( minIndex, : ), lb, ub );
                x=round(x);
                [fit( minIndex ), red ]= FitFunc1p( x( minIndex, : ) );
            end
            for i = (0.5*pop+1) : pop
                i=round(i)
                if choose == 3 || minIndex ~= i
                    person = randi( [1, 0.5*pop], 1 );
                    x( i, : ) = x( i, : ) + (pX(person, :) - x( i, : )) * FL( i );
                    x( i, : ) = Bounds( x( i, : ), lb, ub );
                    x=round(x);
                    [fit( i ), red ]= FitFunc1p( x( i, : ) );
                end
            end   
        end
        
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Update the individual's best fitness vlaue and the global best one
   
    for i = 1 : pop 
        if ( fit( i ) < pFit( i ) )
            pFit( i ) = fit( i );
            pX( i, : ) = x( i, : );
        end
        
        if( pFit( i ) < fMin )
            fMin = pFit( i );
            bestX = pX( i, : );
        end
    end
    
         [BSAFitness,index]=sort(pFit);
          
          bred = arqui(index(1,1)).nn; 
    
   
    arquitec(iteration).nn = bred;
    arquitec(iteration).best = fMin;
    arquitec(iteration).capas = bestX;
    arquitec(iteration).iteration = iteration;
    save('redesBSA0909.mat','arquitec')
          
          
      %fprintf(errord,['Error:' num2str(fit(i)) ' Iteracion:' int2str(iteration)  ' Individuos:' int2str(pop) ' Capas: ' int2str(x(i,1)) ' Neuronas capa 1: ' int2str(x(i,2))  ' Neuronas Capa 2: ' int2str(x(i,3)) '\n']);
     
     
 end

end
% End of the main program

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following functions are associated with the main program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is the objective function
% function y = Sphere( x )
% y = sum( x .^ 2 );

% Application of simple limits/bounds
function s = Bounds( s, Lb, Ub)
  % Apply the lower bound vector
  temp = s;
  I = temp < Lb;
  temp(I) = Lb(I);
  
  % Apply the upper bound vector 
  J = temp > Ub;
  temp(J) = Ub(J);
  % Update this new move 
  s = temp;
end
%--------------------------------------------------------------------------
% This function generate "dim" values, all of which are different from
%  the value of "tabu"
function value = randiTabu( min, max, tabu, dim )
value = ones( dim, 1 ) .* max .* 2;
num = 1;
while ( num <= dim )
    temp = randi( [min, max], 1, 1 );
    if( length( find( value ~= temp ) ) == dim && temp ~= tabu )
        value( num ) = temp;
        num = num + 1;
    end
end
end