function writeDynamics(dyn)

filename = 'rocketDynamics';

comments{1} = ['ddq = ' upper(filename) '(t,q,dq,u,P)'];
comments{2} = ' ';
comments{3} = 'FUNCTION:  This function computes the dynamics of a double';
comments{4} = '    pendulum, and is designed to be called from ode45. The';
comments{5} = '    model allows for arbitrary mass and inertia for each';
comments{6} = '    link, but no friction or actuation';
comments{7} = ' ';
comments{8}  = 'INPUTS: ';
comments{9}  = '    t = time. ';
comments{10} = '    q = [3xn] matrix of states.';
comments{11} = '    dq = [3xn] matrix of state rates.';
comments{12} = '    u = [2xn] matrix of inputs.';
comments{13} = '    P = struct of parameters';
comments{14} = 'OUTPUTS: ';
comments{15} = '    dq = [3xn] matrix of state accelerations';
comments{16} = ' ';
comments{17} = 'NOTES:';
comments{18} = ['    This file was automatically generated by ' mfilename]; 

params{1} = {'m','rocket mass'};
params{2} = {'G ','gravity constant'};
params{3} = {'mPlanet','mass of the planet'};
params{4} = {'l','rocket length'};
params{5} = {'d','rocket engine eccentricity'};

states{1} = {'r','distance between planet CoM and rocket CoM'};
states{2} = {'th1','angle of vector between planet and rocket'};
states{3} = {'th2','absolute orientation of the rocket'};

input{1} = {'u1','Rocket engine one force'};
input{2} = {'u2','Rocket engine two force'};

dstates{1} = {'dr','distance between planet CoM and rocket CoM - rate'};
dstates{2} = {'dth1','angle of vector between planet and rocket -rate'};
dstates{3} = {'dth2','absolute orientation of the rocket - rate'};

ddstates{1} = {'ddr','distance between planet CoM and rocket CoM - accel'};
ddstates{2} = {'ddth1','angle of vector between planet and rocket - accel'};
ddstates{3} = {'ddth2','absolute orientation of the rocket - accel'};


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                               write file                                %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
fid = fopen([filename '.m'],'w');

fprintf(fid, ['function ddq = ' filename '(~,q,dq,u,P) \n']);

for i=1:length(comments)
    fprintf(fid,['%%' comments{i} '\n']);
end
fprintf(fid,'\n');

for i=1:length(params)
    fprintf(fid,[params{i}{1} ' = P.' params{i}{1} '; %%' params{i}{2} '\n']);
end
fprintf(fid,'\n');

for i=1:length(states)
    fprintf(fid,[states{i}{1} ' = q(' num2str(i) ',:); %%' states{i}{2} '\n']);
end
fprintf(fid,'\n');

for i=1:length(dstates)
    fprintf(fid,[dstates{i}{1} ' = dq(' num2str(i) ',:); %%' dstates{i}{2} '\n']);
end
fprintf(fid,'\n');

for i=1:length(input)
    fprintf(fid,[input{i}{1} ' = u(' num2str(i) ',:); %%' input{i}{2} '\n']);
end
fprintf(fid,'\n');

for i=1:length(ddstates)
    fprintf(fid,[ddstates{i}{1} ' =  ' vectorize(char(dyn(i))) ';\n']);
end
fprintf(fid,'\n');

fprintf(fid,'ddq = [ddr;ddth1;ddth2];\n');


fprintf(fid,'end \n');

fclose(fid);

end