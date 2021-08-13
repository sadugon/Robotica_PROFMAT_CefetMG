## Código para enviar comandos para as juntas no CoppeliaSim
## Samuel Duque Gonçalves - 2020

function set_target(j1,j2,j3,j4,j5,j6)
  j=[j1,j2,j3,j4,j5,j6];
sim=remApiSetup();
simxFinish(-1); 
  clientID=simxStart('127.0.0.1',19999,true,true,5000,5);
        [r,hand(1)]=simxGetObjectHandle(clientID,'IRB140_joint1',...
              sim.simx_opmode_blocking);
        [r,hand(2)]=simxGetObjectHandle(clientID,'IRB140_joint2',sim.simx_opmode_blocking);
        [r,hand(3)]=simxGetObjectHandle(clientID,'IRB140_joint3',sim.simx_opmode_blocking);
        [r,hand(4)]=simxGetObjectHandle(clientID,'IRB140_joint4',sim.simx_opmode_blocking);
        [r,hand(5)]=simxGetObjectHandle(clientID,'IRB140_joint5',sim.simx_opmode_blocking);
        [r,hand(6)]=simxGetObjectHandle(clientID,'IRB140_joint6',sim.simx_opmode_blocking);
  
  for i=1:6
    simxSetJointTargetPosition(clientID,hand(i),deg2rad(j(i)),sim.simx_opmode_oneshot);
  end
  
endfunction