% --- Executes on button press in berechneK.
function berechneK_Callback(hObject, eventdata, handles)
	% hObject    handle to berechneK (see GCBO)
	% eventdata  reserved - to be defined in a future version of MATLAB
	% handles    structure with handles and user data (see GUIDATA)

	% Struktur mit den Handles aller Objekte der GUI erzeugen
	h = guihandles();

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Auslesen der Matrix Q
	q11 = str2num(get(h.Q11,'String'));
	q22 = str2num(get(h.Q22,'String'));
	q33 = str2num(get(h.Q33,'String'));
	q44 = str2num(get(h.Q44,'String'));

	Q = diag([q11 q22 q33 q44]);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Auslesen von R
	R = str2num(get(h.R,'String'));
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Auslesen des Arbeitpunkts
	% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	% Ggf. an eigene Codierung des Arbeitspunktes anpassen!
	% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    AP = [0 0 0 0];
	value1 = get(h.slider_AP,'Value');
        AP(1) = value1*pi;
	value2 = get(h.AP_2_1,'Value');
	if (value2 == 1)
		AP(3) = pi;
	else % (value == 0)
		AP(3) = 0;
    end    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [f_m, h_m] = nonlinear_model();
    
	[A, B, C, D, M_AP] = linearisierung(f_m, h_m, AP);
    
    stObs = getappdata(h.figure1,'stObs');
    stObs.A = A;
    stObs.B = B;
    stObs.C = C;
    setappdata(h.figure1,'stObs',stObs);
    
	[K, poleRK] = berechneLQR(A, B, Q, R);
	% Anzeigen des Vektors 'K' im Textfeld 'reglerK'

 	set(h.reglerK, 'String', num2str(K));
	set(h.poleRK, 'String', num2str(poleRK'));
	
    set(h.M_AP,'String',num2str(M_AP));
% end function berechneK_Callback
