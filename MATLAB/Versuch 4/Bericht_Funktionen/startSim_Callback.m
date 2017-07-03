% --- Executes on button press in startSim.
function startSim_Callback(hObject, eventdata, handles)
% hObject    handle to startSim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Initialisiert variable zum stoppen der Animation
global stopAnimation;
stopAnimation = false;

h = guihandles();
cla(h.axes1);

% Startwerte aus der GUI auslesen
x0(1,1) = str2num(get(h.x01,'String'));
x0(2,1) = str2num(get(h.x02,'String'));
x0(3,1) = str2num(get(h.x03,'String'));
x0(4,1) = str2num(get(h.x04,'String'));

% Arbeitspunkt aus der GUI auslesen
AP = [0 0 0 0];
value1 = get(h.slider_AP,'Value');
    AP(1) = value1*pi;
value2 = get(h.AP_2_1,'Value');
if (value2 == 1)
    AP(3) = pi;
else % (value == 0)
    AP(3) = 0;
end    
M_AP = str2num(get(h.M_AP,'String'));

% Regler aus der GUI auslesen
K = str2num(get(h.reglerK,'String'));
stPendel = ladePendel();

% Reglerpole aus der GUI auslesen
stObs = getappdata(h.figure1,'stObs');
stObs.pole(1) = str2num(get(h.lam_b_1,'String'));
stObs.pole(2) = str2num(get(h.lam_b_2,'String'));
stObs.pole(3) = str2num(get(h.lam_b_3,'String'));
stObs.pole(4) = str2num(get(h.lam_b_4,'String'));

% Reglerstartwerte aus der GUI auslesen
stObs.x0(1) = str2num(get(h.x01b,'String'));
stObs.x0(2) = str2num(get(h.x02b,'String'));
stObs.x0(3) = str2num(get(h.x03b,'String'));
stObs.x0(4) = str2num(get(h.x04b,'String'));

% Fragt ab ob mit oder ohne Beobachter 
logic = get(h.popupmenu2,'Value');
if logic == 1
    stObs.switch  = true;
else
    stObs.switch = false;
end

% Beobachter berechnen
stObs.L = berechneBeobachter(stObs.A,stObs.C,stObs.pole);
setappdata(h.figure1,'stObs',stObs);

% Simulation des Modells
[vT, mX, mXobs, u] = runPendel(stPendel, AP, K, x0, M_AP, stObs);

% Variablen zum plotten in den Base Workspace schreiben
assignin('base','vT',vT);
assignin('base','mX',mX);
assignin('base','mXobs',mXobs);
assignin('base','u',u);
assignin('base','M_AP',M_AP);
assignin('base','x0',x0);

% Abfragen ob die animation aufgezeichnet werden soll
if get(h.aufnahme,'Value') == 1
    record = true;
else
    record = false;
end

%Animation des Pendels ohne avi-Video (Viertes Argument)
animierePendel(vT,mX,stPendel,h.axes1,record);
