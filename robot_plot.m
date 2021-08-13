## Código para plotar o braço robótico
## Samuel Duque Gonçalves - 2020
function Tef=robot_plot(j1,j2,j3,j4,j5,j6)


##Matriz 1
T(:,:,1)=[cosd(j1),-sind(j1),0,0;
    sind(j1),cosd(j1),0,0.069;
    0,0,1,0;
    0,0,0,1];
    
##Matriz 2
#T(:,:,3)=[cosd(j2),0,-sind(j2),0;
T(:,:,2)=[1,0,0,0;
    0,cosd(j2),-sind(j2),.07;
    0,sind(j2),cosd(j2),.3521;#0;
    0,0,0,1];    
    
##Matriz 3
##T(:,:,5)=[cosd(j3),0,-sind(j3),0;
T(:,:,3)=[1,0,0,0;
    0,cosd(j3),-sind(j3),0;
    0,sind(j3),cosd(j3),.36;
    0,0,0,1]; 
    
##Matriz 4
##T(:,:,7)=[1,0,0,0;
T(:,:,4)=[cosd(j4),0,sind(j4),0;
    0,1,0,.226;
    -sind(j4),0,cosd(j4),0;
    0,0,0,1]; 

##Matriz 5
##T(:,:,8)=[cosd(j5),0,-sind(j5),0;
T(:,:,5)=[1,0,0,0;
    0,cosd(j5),-sind(j5),.154;
    0,sind(j5),cosd(j5),0;
    0,0,0,1];  

##Matriz 6
T(:,:,6)=[cosd(j6),0,sind(j6),0;
    0,1,0,0.046;
    -sind(j6),0,cosd(j6),0;
    0,0,0,1]; 

##Matriz 6   
T(:,:,7)=[1,0,0,0;
    0,1,0,.019;
    0,0,1,0;
    0,0,0,1]; 
   
  
#Multiplicar as matrizes
T0=eye(4);  
Tef=T0;
for ind=1:7
  Tef=Tef*T(:,:,ind);
  pef(:,ind)=Tef(1:3,4);
end;


#Plotar os vetores e suas legendas
origx = quiver3(0,0,0,0.1*T0(1,1),0.1*T0(2,1),0.1*T0(3,1), 'Color', 'red','linestyle','--',"linewidth",1,"linewidth",2);
hold on #Mantem os plots na mesma figura
origx_line = line([0,0.1*T0(1,1)],[0,0.1*T0(2,1)],[0,0.1*T0(3,1)], 'Color', 'red','linestyle','--',"visible","off","displayname",'\bfx\rm - Base',"linewidth",2);
origy = quiver3(0,0,0,0.1*T0(1,2),0.1*T0(2,2),0.1*T0(3,2), 'Color', 'green','linestyle','--',"linewidth",1,"linewidth",2);
origy_line = line([0,0.1*T0(1,2)],[0,0.1*T0(2,2)],[0,0.1*T0(3,2)], 'Color', 'green','linestyle','--',"visible","off","displayname",'\bfy\rm - Base',"linewidth",2);
origz = quiver3(0,0,0,0.1*T0(1,3),0.1*T0(2,3),0.1*T0(3,3), 'Color', 'blue','linestyle','--',"linewidth",1,"linewidth",2);
origz_line = line([0,0.1*T0(1,3)],[0,0.1*T0(2,3)],[0,0.1*T0(3,3)], 'Color', 'blue','linestyle','--',"visible","off","displayname",'\bfz\rm - Base',"linewidth",2);

efx = quiver3(pef(1,ind),pef(2,ind),pef(3,ind),0.1*Tef(1,1),0.1*Tef(2,1),0.1*Tef(3,1), 'Color', 'red',"linewidth",1,"linewidth",2);
efx_line = line([pef(1,ind),0.1*Tef(1,1)],[pef(2,ind),0.1*Tef(2,1)],[pef(3,ind),0.1*Tef(3,1)], 'Color', 'red','linestyle','-',"visible","off","displayname",'\bfx\rm - Efetuador',"linewidth",2);
efy = quiver3(pef(1,ind),pef(2,ind),pef(3,ind),0.1*Tef(1,2),0.1*Tef(2,2),0.1*Tef(3,2), 'Color', 'green',"linewidth",1,"linewidth",2);
efy_line = line([pef(1,ind),0.1*Tef(1,2)],[pef(2,ind),0.1*Tef(2,2)],[pef(3,ind),0.1*Tef(3,2)], 'Color', 'green','linestyle','-',"visible","off","displayname",'\bfy\rm - Efetuador',"linewidth",2);
efz = quiver3(pef(1,ind),pef(2,ind),pef(3,ind),0.1*Tef(1,3),0.1*Tef(2,3),0.1*Tef(3,3), 'Color', 'blue',"linewidth",1,"linewidth",2);
efz_line = line([pef(1,ind),0.1*Tef(1,3)],[pef(2,ind),0.1*Tef(2,3)],[pef(3,ind),0.1*Tef(3,3)], 'Color', 'blue','linestyle','-',"visible","off","displayname",'\bfz\rm - Efetuador',"linewidth",2);


#Plotar os elos como linhas
for ind=2:7
  line([pef(1,ind-1),pef(1,ind)],[pef(2,ind-1),pef(2,ind)],[pef(3,ind-1),pef(3,ind)],"linewidth",2,"displayname",['Elo ',num2str(ind-1)]);
end;

hold off;

#Configurar legenda, eixos e fontes
axis equal;
set(gca, "linewidth", 2, "fontsize", 12);
leg=legend ("location", "southeast");
set(leg, "fontsize", 12);


endfunction
