## Código para criar a Interface Gráfica de Usuário
## Samuel Duque Gonçalves - 2020

##Códigos iniciais
clear all
close all
clear h
clc
graphics_toolkit qt

##Conectar ao CoppeliaSim?
h.online=true;#true=conectado; false=desconectado

##Se for trabalhar online, executar função para conexão
if h.online
  conect
endif;


#Inicializar valores das juntas:
h.j1=0;
h.j2=0;
h.j3=0;
h.j4=0;
h.j5=0;
h.j6=0;
h.alfa=0;
h.beta=0;
h.gama=0;
h.Tef=eye(4);

##Criar tela com gráfico
figure(1, 'position',[get(0,"screensize")(3:4)/4 get(0,"screensize")(3:4)/2]);
h.ax = axes ("position", [0 0.1 0.5 0.8]);


##Função para atualizar a plotagem
function update_plot (obj, init = false)

  h = guidata (obj);
  replot = false;
  recalc = false;
  
  switch (gcbo)
    case {h.linecolor_radio_2D}
      set (h.linecolor_radio_3D, "value", 0);
      h.j1=0;
      h.j4=0;
      h.j6=0;
      set (h.joint1_slider,"Value",0, "enable", "off");
      set (h.joint4_slider,"Value",0, "enable", "off");
      set (h.joint6_slider,"Value",0, "enable", "off");      
      set (h.joint1_edit,"string","0", "enable", "off");
      set (h.joint4_edit,"string","0", "enable", "off");
      set (h.joint6_edit,"string","0", "enable", "off");
      recalc = true;
    case {h.linecolor_radio_3D}
      set (h.linecolor_radio_2D, "value", 0);
      set (h.joint1_slider, "enable", "on");
      set (h.joint4_slider, "enable", "on");
      set (h.joint6_slider, "enable", "on"); 
      set (h.joint1_edit, "enable", "on");
      set (h.joint4_edit, "enable", "on");
      set (h.joint6_edit, "enable", "on");      
    case {h.joint1_slider}
      set (h.joint1_edit, "string", num2str(get (h.joint1_slider, "value")))
      recalc = true;
    case {h.joint2_slider}
      set (h.joint2_edit, "string", num2str(get (h.joint2_slider, "value")));
      recalc = true;
    case {h.joint3_slider}
      set (h.joint3_edit, "string", num2str(get (h.joint3_slider, "value")));
      recalc = true;
    case {h.joint4_slider}
      set (h.joint4_edit, "string", num2str(get (h.joint4_slider, "value")));
      recalc = true;
    case {h.joint5_slider}
      set (h.joint5_edit, "string", num2str(get (h.joint5_slider, "value")));
      recalc = true;
    case {h.joint6_slider}
      set (h.joint6_edit, "string", num2str(get (h.joint6_slider, "value")));
      recalc = true;
    case {h.joint1_edit}
      set (h.joint1_slider, "Value",str2num(get (h.joint1_edit, "String")));
      recalc = true;
    case {h.joint2_edit}
      set (h.joint2_slider, "Value",str2num(get (h.joint2_edit, "String")));
      recalc = true;
    case {h.joint3_edit}
      set (h.joint3_slider, "Value",str2num(get (h.joint3_edit, "String")));
      recalc = true;
    case {h.joint4_edit}
      set (h.joint4_slider, "Value",str2num(get (h.joint4_edit, "String")));
      recalc = true;
    case {h.joint5_edit}
      set (h.joint5_slider, "Value",str2num(get (h.joint5_edit, "String")));
      recalc = true;
    case {h.joint6_edit}
      set (h.joint6_slider, "Value",str2num(get (h.joint6_edit, "String")));
      recalc = true;
   endswitch

  if (recalc || init) #No slider ou no inicio
    h.j1=get (h.joint1_slider, "value");
    h.j2=get (h.joint2_slider, "value");
    h.j3=get (h.joint3_slider, "value");
    h.j4=get (h.joint4_slider, "value");
    h.j5=get (h.joint5_slider, "value");
    h.j6=get (h.joint6_slider, "value");
    h.Tef=robot_plot(h.j1,h.j2,h.j3,h.j4,h.j5,h.j6);
    
    if h.online
    set_target(h.j1,h.j2,h.j3,h.j4,h.j5,h.j6);
    endif;
    
    
    %target(h.j1,h.j2,h.j3,h.j4,h.j5,h.j6);
    set (h.se3_matrix, "String",num2str((round(1000*h.Tef))/1000, "%10.4f"));
    if (get (h.linecolor_radio_2D, "value")==1)
      view (90, 0);
    else
      view (135, 30)
    endif
  endif

 
  
endfunction
                            
                            
## Modo de controle
h.linecolor_label = uicontrol ("style", "text",
                               "units", "normalized",
                               "string", "Dimensões:",
                               "horizontalalignment", "left",
                               "position", [0.6 0.9 0.35 0.04]);

gp = uibuttongroup ( "Position", [ 0.8 0.9 .2 .04]);
h.linecolor_radio_2D = uicontrol (gp,"style", "radiobutton",
                                    "units", "normalized",
                                    "string", "2D",
                                    "callback", @update_plot,
                                   "value", 0,
                                    "position", [0 0 1 1]);

h.linecolor_radio_3D = uicontrol (gp,"style", "radiobutton",
                                   "units", "normalized",
                                   "string", "3D",
                                   "callback", @update_plot,
                                   "value", 1,
                                   "position", [0.5 0 1 1]);             

#Descrição das juntas       
h.joint1_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Junta 1 (-180° a 180°):",
                           "horizontalalignment", "left",
                           "position", [0.56 0.85 0.34 0.04]);  
       
h.joint2_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Junta 2 (-100° a 100°):",
                           "horizontalalignment", "left",
                           "position", [0.56 0.75 0.34 0.04]);  
       
h.joint3_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Junta 3 (-140° a 140°):",
                           "horizontalalignment", "left",
                           "position", [0.56 0.65 0.34 0.04]);  
       
h.joint4_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Junta 4 (-180° a 180°):",
                           "horizontalalignment", "left",
                           "position", [0.56 0.55 0.34 0.04]);  
       
h.joint5_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Junta 5 (-115° a 115°):",
                           "horizontalalignment", "left",
                           "position", [0.56 0.45 0.34 0.04]);  
       
h.joint6_label = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", "Junta 6 (-180° a 180°):",
                           "horizontalalignment", "left",
                           "position", [0.56 0.35 0.34 0.04]);  

       
##Slider de controle das juntas                            
h.joint1_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            'Min',-180,
                            'Max', 180,
                            "callback", @update_plot,
                            "value", 0,
                            "position",[0.56 0.8 0.34 0.04]);
                            
h.joint2_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            'Min',-100,
                            'Max', 100,
                            "callback", @update_plot,
                            "value", 0,
                            "position",[0.56 0.7 0.34 0.04]);
h.joint3_slider = uicontrol ("style", "slider",
                            'Min',-140,
                            'Max', 140,
                            "units", "normalized",
                            "string", "slider",
                            "callback", @update_plot,
                            "value", 0,
                            "position", [0.56 0.6 0.34 0.04]);
h.joint4_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            'Min',-180,
                            'Max', 180,
                            "callback", @update_plot,
                            "value", 0,
                            "position", [0.56 0.5 0.34 0.04]);
h.joint5_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            'Min',-115,
                            'Max', 115,
                            "callback", @update_plot,
                            "value", 0,
                            "position", [0.56 0.4 0.34 0.04]);
h.joint6_slider = uicontrol ("style", "slider",
                            "units", "normalized",
                            "string", "slider",
                            'Min',-180,
                            'Max', 180,
                            "callback", @update_plot,
                            "value", 0,
                            "position", [0.56 0.3 0.34 0.04]);

                            
##edit de controle das juntas                            
h.joint1_edit = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "0",
                               "callback", @update_plot,
                               "position", [0.9 0.8 0.1 0.04]);
   
h.joint2_edit = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "0",
                               "callback", @update_plot,
                               "position", [0.9 0.7 0.1 0.04]);    

h.joint3_edit = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "0",
                               "callback", @update_plot,
                               "position", [0.9 0.6 0.1 0.04]);
   
h.joint4_edit = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "0",
                               "callback", @update_plot,
                               "position", [0.9 0.5 0.1 0.04]);  

h.joint5_edit = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "0",
                               "callback", @update_plot,
                               "position", [0.9 0.4 0.1 0.04]);
   
h.joint6_edit = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "0",
                               "callback", @update_plot,
                               "position", [0.9 0.3 0.1 0.04]);                                 

 
h.se3_matrix_title = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", {"Matriz de transformação"; "homogênea do efetuador."; "T="},
                           "horizontalalignment", "left",
                           "position", [0.56 0.16 0.34 0.08]);  
h.se3_matrix = uicontrol ("style", "text",
                           "units", "normalized",
                           "string", num2str((round(1000*h.Tef))/1000, "%10.4f"),
                           "horizontalalignment", "left",
                           "position", [0.56 0 0.34 0.16]);                             

set (gcf, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (gcf, h)
update_plot (gcf, true);