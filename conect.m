## Código para conectar ao CoppeliaSim
## Samuel Duque Gonçalves - 2020
function conect()

sim=remApiSetup();
simxFinish(-1);
clientID=simxStart('127.0.0.1',19999,true,true,5000,5);

 if (clientID>-1)
   disp('Conectado ao servidor de API remoto');
 else
   disp('Falha ao conectar ao servidor de API remoto');
 end

endfunction
