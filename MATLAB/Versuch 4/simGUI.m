function varargout = simGUI(varargin)
% SIMGUI M-file for simGUI.fig
%      SIMGUI, by itself, creates a new SIMGUI or raises the existing
%      singleton*.
%
%      H = SIMGUI returns the handle to a new SIMGUI or the handle to
%      the existing singleton*.
%
%      SIMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMGUI.M with the given input arguments.
%
%      SIMGUI('Property','Value',...) creates a new SIMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simGUI

% Last Modified by GUIDE v2.5 27-Jun-2017 17:37:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @simGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before simGUI is made visible.
function simGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simGUI (see VARARGIN)

% Choose default command line output for simGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Arbeitspunkt
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in AP_2_1.
function AP_2_1_Callback(hObject, eventdata, handles)
	% hObject    handle to AP_2_1 (see GCBO)
	% eventdata  reserved - to be defined in a future version of MATLAB
	% handles    structure with handles and user data (see GUIDATA)

	h = guihandles();

	value=get(hObject,'Value');
	if value == 1
		set(h.AP_2_2,'Value',0);

	elseif value == 0
		set(h.AP_2_2,'Value',1);

	end
	% Hint: get(hObject,'Value') returns toggle state of AP_2_1

% --- Executes on button press in AP_2_2.
function AP_2_2_Callback(hObject, eventdata, handles)
% hObject    handle to AP_2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    h = guihandles();

	value=get(hObject,'Value');
	if value == 1
		set(h.AP_2_1,'Value',0);

	elseif value == 0
		set(h.AP_2_1,'Value',1);

    end
% Hint: get(hObject,'Value') returns toggle state of AP_2_2    



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Arbeitspunkt ENDE
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Berechnung Regler reglerK
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Berechnung Regler reglerK ENDE
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix R 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function R_Callback(hObject, eventdata, handles)
% hObject    handle to R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of R as text
%        str2double(get(hObject,'String')) returns contents of R as a double

% --- Executes during object creation, after setting all properties.
function R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix R ENDE
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix Q
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Q11_Callback(hObject, eventdata, handles)
% hObject    handle to Q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Q11 as text
%        str2double(get(hObject,'String')) returns contents of Q11 as a double
% --- Executes during object creation, after setting all properties.
function Q11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Q22_Callback(hObject, eventdata, handles)
% hObject    handle to Q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Q22 as text
%        str2double(get(hObject,'String')) returns contents of Q22 as a
%        double
% --- Executes during object creation, after setting all properties.
function Q22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Q33_Callback(hObject, eventdata, handles)
% hObject    handle to Q33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Q33 as text
%        str2double(get(hObject,'String')) returns contents of Q33 as a
%        double
% --- Executes during object creation, after setting all properties.
function Q33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Q44_Callback(hObject, eventdata, handles)
% hObject    handle to Q44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of Q44 as text
%        str2double(get(hObject,'String')) returns contents of Q44 as a
%        double
% --- Executes during object creation, after setting all properties.
function Q44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 1);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix Q ENDE
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function reglerK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reglerK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider_AP_Callback(hObject, eventdata, handles)
% hObject    handle to slider_AP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    h = guihandles();
    value_AP = get(h.slider_AP,'Value');
    set(h.AP_1,'String',[num2str(value_AP*180) '°'])
    
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_AP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_AP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in startSim.
function startSim_Callback(hObject, eventdata, handles)
% hObject    handle to startSim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stopAnimation;
stopAnimation = false;

h = guihandles();
cla(h.axes1);

x0(1,1) = str2num(get(h.x01,'String'));
x0(2,1) = str2num(get(h.x02,'String'));
x0(3,1) = str2num(get(h.x03,'String'));
x0(4,1) = str2num(get(h.x04,'String'));

AP = [0 0 0 0];
value1 = get(h.slider_AP,'Value');
    AP(1) = value1*pi;
value2 = get(h.AP_2_1,'Value');
if (value2 == 1)
    AP(3) = pi;
else % (value == 0)
    AP(3) = 0;
end    
    
K = str2num(get(h.reglerK,'String'));
stPendel = ladePendel();
M_AP = str2num(get(h.M_AP,'String'));



stObs = getappdata(h.figure1,'stObs');
stObs.pole(1) = str2num(get(h.lam_b_1,'String'));
stObs.pole(2) = str2num(get(h.lam_b_2,'String'));
stObs.pole(3) = str2num(get(h.lam_b_3,'String'));
stObs.pole(4) = str2num(get(h.lam_b_4,'String'));

stObs.x0(1) = str2num(get(h.x01b,'String'));
stObs.x0(2) = str2num(get(h.x02b,'String'));
stObs.x0(3) = str2num(get(h.x03b,'String'));
stObs.x0(4) = str2num(get(h.x04b,'String'));

logic = get(h.popupmenu2,'Value');
if logic == 1
    stObs.switch  = true;
else
    stObs.switch = false;
end

% Beobachter berechnen
stObs.L = berechneBeobachter(stObs.A,stObs.C,stObs.pole);
setappdata(h.figure1,'stObs',stObs);

%Simulation des Modells
[vT, mX, mXobs, u] = runPendel(stPendel, AP, K, x0, M_AP, stObs);

% Variablen zum plotten in den Base Workspace schreiben
assignin('base','vT',vT);
assignin('base','mX',mX);
assignin('base','mXobs',mXobs);
assignin('base','u',u);
assignin('base','M_AP',M_AP);
assignin('base','x0',x0);

if get(h.aufnahme,'Value') == 1
    record = true;
else
    record = false;
end

%Animation des Pendels ohne avi-Video (Viertes Argument)
animierePendel(vT,mX,stPendel,h.axes1,record);




function x01_Callback(hObject, eventdata, handles)
% hObject    handle to x01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x01 as text
%        str2double(get(hObject,'String')) returns contents of x01 as a double


% --- Executes during object creation, after setting all properties.
function x01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 0);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x02_Callback(hObject, eventdata, handles)
% hObject    handle to x02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x02 as text
%        str2double(get(hObject,'String')) returns contents of x02 as a double


% --- Executes during object creation, after setting all properties.
function x02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 0);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x03_Callback(hObject, eventdata, handles)
% hObject    handle to x03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x03 as text
%        str2double(get(hObject,'String')) returns contents of x03 as a double


% --- Executes during object creation, after setting all properties.
function x03_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 'pi');

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x04_Callback(hObject, eventdata, handles)
% hObject    handle to x04 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x04 as text
%        str2double(get(hObject,'String')) returns contents of x04 as a double


% --- Executes during object creation, after setting all properties.
function x04_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x04 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 0);

function M_AP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reglerK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 0);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stopAnimation.
function stopAnimation_Callback(hObject, eventdata, handles)
% hObject    handle to stopAnimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stopAnimation;
stopAnimation = true;




function lam_b_1_Callback(hObject, eventdata, handles)
% hObject    handle to lam_b_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lam_b_1 as text
%        str2double(get(hObject,'String')) returns contents of lam_b_1 as a double


% --- Executes during object creation, after setting all properties.
function lam_b_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lam_b_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', '-10');

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lam_b_2_Callback(hObject, eventdata, handles)
% hObject    handle to lam_b_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lam_b_2 as text
%        str2double(get(hObject,'String')) returns contents of lam_b_2 as a double


% --- Executes during object creation, after setting all properties.
function lam_b_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lam_b_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', '-15');

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lam_b_3_Callback(hObject, eventdata, handles)
% hObject    handle to lam_b_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lam_b_3 as text
%        str2double(get(hObject,'String')) returns contents of lam_b_3 as a double


% --- Executes during object creation, after setting all properties.
function lam_b_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lam_b_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', '-20');

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lam_b_4_Callback(hObject, eventdata, handles)
% hObject    handle to lam_b_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lam_b_4 as text
%        str2double(get(hObject,'String')) returns contents of lam_b_4 as a double


% --- Executes during object creation, after setting all properties.
function lam_b_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lam_b_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', '-21'); 

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String',{'Beobachter','Zustandsrückführung'});

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x01b_Callback(hObject, eventdata, handles)
% hObject    handle to x01b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x01b as text
%        str2double(get(hObject,'String')) returns contents of x01b as a double


% --- Executes during object creation, after setting all properties.
function x01b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x01b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 0);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x02b_Callback(hObject, eventdata, handles)
% hObject    handle to x02b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x02b as text
%        str2double(get(hObject,'String')) returns contents of x02b as a double


% --- Executes during object creation, after setting all properties.
function x02b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x02b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 0);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x03b_Callback(hObject, eventdata, handles)
% hObject    handle to x03b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x03b as text
%        str2double(get(hObject,'String')) returns contents of x03b as a double


% --- Executes during object creation, after setting all properties.
function x03b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x03b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 'pi');

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x04b_Callback(hObject, eventdata, handles)
% hObject    handle to x04b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x04b as text
%        str2double(get(hObject,'String')) returns contents of x04b as a double


% --- Executes during object creation, after setting all properties.
function x04b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x04b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject, 'String', 0);

% Hint: edit controls usually have a white background on Windows
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in aufnahme.
function aufnahme_Callback(hObject, eventdata, handles)
% hObject    handle to aufnahme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of aufnahme
