function Input_data=Eingabeformular 
    
    global fi Input_data Name Age Club Positionsliste CA UID Liste_Suche...
           Feld_UID Feld_Alter Feld_Position Feld_Name Feld_Alter_Min...
           Feld_Alter_Max Feld_CA_Min Feld_CA_Max Feld_Position_1...
           Feld_Position_2 Feld_Position_3 Knoepfe_Vergleichsspieler...
           Knoepfe_Vorhersage Knoepfe_SI Knopf_Dateninput;
    
    % eine figure mit dem Eingabeformular wird erstellt
    % sollte die Ergebnis figure noch offen sein, wird diese geleert
    % ansonsten wird eine neue figure erstellt
    if findobj('type','figure','name','Ergebnis');
      clf;
      set(fi,'name','Eingabeformular');
    else
      fi=figure('name','Eingabeformular');
    endif
    % nun werden alle graphischen Elemente auf dem Eingabeformular erstellt
    % Der Name Text wird erstellt
    Text_Name=uicontrol(fi,'units','normalized','style','text','string','Name:',...
              'position',[0.1 0.9 0.15 0.06]);
    % Liste mit der Datenbank wird erstellt
    Liste_Suche=uitable(fi,'data',[Name(1:500),num2cell(Age(1:500)),Club(1:500),...
                Positionsliste(1:500),num2cell(CA(1:500)),num2cell(UID(1:500))],...
                'columnformat',{[] 'long' [] [] 'long' 'long'},'units',...
                'normalized','columnwidth',{160 40 120 120 40 70},'position',...
                [0.1 0.25 0.35 0.6],'columnname',{'Name','Alter','Club',...
                'Position','CA','UID'});
    % Die Texte mit UID, Alter und Position werden erstellt
    Text_UID=uicontrol(fi,'units','normalized','style','text','string','UID:',...
             'position',[0.5 0.9 0.15 0.06]);
    Text_Alter=uicontrol(fi,'units','normalized','style','text','string',...
               'Alter:','position',[0.5 0.8 0.15 0.06]);
    Text_Position=uicontrol(fi,'units','normalized','style','text','string',...
                  'Position:','position',[0.5 0.7 0.15 0.06]);
    % Eingabefelder fuer den Originalspieler werden erstellt
    Feld_UID=uicontrol(fi,'units','normalized','style','edit','position',...
             [0.7 0.9 0.15 0.06]);
    Feld_Alter=uicontrol(fi,'units','normalized','style','edit','position',...
               [0.7 0.8 0.15 0.06]);
    Feld_Position=uicontrol(fi,'units','normalized','style','popupmenu',...
                  'string',{'GK','D(RL)','D(C)','WB(RL)','DM','M(RL)','M(C)',...
                  'AM(RL)','AM(C)','ST'},'position',[0.7 0.7 0.15 0.06]);
    % Eingabefeld fuer die Namenssuche in der Datenbank wird erstellt
    Feld_Name=uicontrol(fi,'units','normalized','style','edit','position',...
              [0.3 0.9 0.15 0.06]);
    % Knoepfe zum Berechnen und Filtern werden erstellt
    % wird der Knopf_Dateninput gedrueckt, so werden alle Daten eingelesen
    Knopf_Dateninput=uicontrol(fi,'units','normalized','style','pushbutton',...
                     'string','Berechnen','position',[0.7 0.1 0.15 0.06],...
                     'callback', @Dateninput);
    % wenn der 'Suchen' Knopf gedrueckt wird, werden die Spieler nach Eingabe gefiltert
    Knopf_Filter_Name=uicontrol(fi,'units','normalized','style','pushbutton',...
                      'string','Suchen','position',[0.3 0.1 0.15 0.06],...
                      'callback', @Filter_Name);
    % Radiobuttons um die Art der Vergleichsspielers, der SI-Berechnung und
    % die Gewichtung festzulegen werden erstellt
    Knoepfe_Vergleichsspieler=uibuttongroup(fi,'units','normalized','Position',...
                               [0.7 0.5 0.15 0.06],'title',('Vergleichsspieler'));
    Radiobutton_gleich=uicontrol(Knoepfe_Vergleichsspieler,'Style','radiobutton',...
                       'String','gleich','units','normalized','Position',...
                       [0.1 0.4 0.6 0.4],'HandleVisibility','off');
    Radiobutton_neu=uicontrol(Knoepfe_Vergleichsspieler,'Style','radiobutton',...
                    'String','neu','units','normalized','Position',...
                    [0.5 0.4 0.6 0.4],'HandleVisibility','off');   
    Knoepfe_Vorhersage=uibuttongroup(fi,'units','normalized','Position',...
                       [0.5 0.5 0.15 0.06],'title',('Vorhersage'));
    Radiobutton_EVO=uicontrol(Knoepfe_Vorhersage,'Style','radiobutton',...
                    'String','EVO','units','normalized','Position',...
                    [0.1 0.4 0.6 0.4],'HandleVisibility','off');
    Radiobutton_ABS=uicontrol(Knoepfe_Vorhersage,'Style','radiobutton',...
                    'String','ABS','units','normalized','Position',...
                    [0.5 0.4 0.6 0.4],'HandleVisibility','off');
    Knoepfe_SI=uibuttongroup(fi,'units','normalized','Position',...
               [0.7 0.6 0.15 0.06],'title',('Gewichtung'));
    Radiobutton_UNG=uicontrol(Knoepfe_SI,'Style','radiobutton','String','UNG',...
                    'units','normalized','Position',[0.1 0.4 0.6 0.4],...
                    'HandleVisibility','off');
    Radiobutton_POS=uicontrol(Knoepfe_SI,'Style','radiobutton','String','POS',...
                    'units','normalized','Position',[0.5 0.4 0.6 0.4],...
                    'HandleVisibility','off');
    % der Text für die Auswahlmoeglichkeiten wird erstellt
    Text_Auswahl=uicontrol(fi,'units','normalized','style','text','string',...
                 'Auswahl:','position',[0.5 0.6 0.15 0.06]);
    
    % Beschriftungen und Eingabefelder fuer den Filterbereich der
    % Vergleichsspieler werden erstellt
    Text_Filter=uicontrol(fi,'units','normalized','style','text','string',...
                'Filter','position',[0.5 0.45 0.075 0.03]);
    Text_Alter_Min=uicontrol(fi,'units','normalized','style','text','string',...
                   'Alter min:','position',[0.5 0.4 0.075 0.03]);
    Feld_Alter_Min=uicontrol(fi,'units','normalized','style','edit',...
                   'position',[0.6 0.4 0.075 0.03]);
    Text_Alter_Max=uicontrol(fi,'units','normalized','style','text','string',...
                   'Alter max:','position',[0.7 0.4 0.075 0.03]);
    Feld_Alter_Max=uicontrol(fi,'units','normalized','style','edit',...
                   'position',[0.8 0.4 0.075 0.03]);
    Text_CA_Min=uicontrol(fi,'units','normalized','style','text','string',...
                'CA min:','position',[0.5 0.35 0.075 0.03]);
    Feld_CA_Min=uicontrol(fi,'units','normalized','string','75','style',...
                'edit','position',[0.6 0.35 0.075 0.03]);
    Text_CA_Max=uicontrol(fi,'units','normalized','style','text','string',...
                'CA max:','position',[0.7 0.35 0.075 0.03]);
    Feld_CA_Max=uicontrol(fi,'units','normalized','string','200','style',...
                'edit','position',[0.8 0.35 0.075 0.03]);
    Text_Positionen=uicontrol(fi,'units','normalized','style','text','string',...
                    'Positionen:','position',[0.5 0.3 0.075 0.03]);
    Feld_Position_1=uicontrol(fi,'units','normalized','style','popupmenu',...
                    'position',[0.6 0.3 0.075 0.03],'string',{'GK','D (R)',...
                    'D (C)','D (L)','WB (R)','WB (L)','DM','M (R)','M (C)',...
                    'M (L)','AM (R)','AM (C)','AM (L)','ST'});
    Feld_Position_2=uicontrol(fi,'units','normalized','style','popupmenu',...
                    'position',[0.7 0.3 0.075 0.03],'string',{'GK','D (R)',...
                    'D (C)','D (L)','WB (R)','WB (L)','DM','M (R)','M (C)',...
                    'M (L)','AM (R)','AM (C)','AM (L)','ST','optional'},...
                    'value',15);
    Feld_Position_3=uicontrol(fi,'units','normalized','style','popupmenu',...
                    'position',[0.8 0.3 0.075 0.03],'string',{'GK','D (R)',...
                    'D (C)','D (L)','WB (R)','WB (L)','DM','M (R)','M (C)',...
                    'M (L)','AM (R)','AM (C)','AM (L)','ST','optional'},...
                    'value',15);
    % Knopf um Spielerliste zu Filtern wird erstellt
    Knopf_Filter=uicontrol(fi,'units','normalized','style','pushbutton',...
                 'string','Filtern','position',[0.7 0.25 0.075 0.03],...
                 'callback', @Filter);
    % die Funktion wird pausiert und erst fortgesetzt, wenn der Knopf 'Berechnen'
    % gedrueckt wird
    waitfor(Knopf_Dateninput,'value');
    
endfunction
  
  
    