function varargout = GrafAO(varargin)
% GRAFAO M-file for GrafAO.fig
%      GRAFAO, by itself, creates a new GRAFAO or raises the existing
%      singleton*.
%
%      H = GRAFAO returns the handle to a new GRAFAO or the handle to
%      the existing singleton*.
%
%      GRAFAO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAFAO.M with the given input arguments.
%
%      GRAFAO('Property','Value',...) creates a new GRAFAO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GrafAO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GrafAO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GrafAO

% Last Modified by GUIDE v2.5 07-Apr-2013 02:25:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GrafAO_OpeningFcn, ...
                   'gui_OutputFcn',  @GrafAO_OutputFcn, ...
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


% --- Executes just before GrafAO is made visible.
function GrafAO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GrafAO (see VARARGIN)

% Choose default command line output for GrafAO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GrafAO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GrafAO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Num_Callback(hObject, eventdata, handles)
% hObject    handle to Num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Num as text
%        str2double(get(hObject,'String')) returns contents of Num as a double


% --- Executes during object creation, after setting all properties.
function Num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Denom_Callback(hObject, eventdata, handles)
% hObject    handle to Denom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Denom as text
%        str2double(get(hObject,'String')) returns contents of Denom as a double


% --- Executes during object creation, after setting all properties.
function Denom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Denom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xmin = str2num(get(handles.edit_xmin,'String'));
xmax = str2num(get(handles.edit_xmax,'String'));
ymin = str2num(get(handles.edit_ymin,'String'));
ymax = str2num(get(handles.edit_ymax,'String'));
x = sym('x');
m = sym('m');
b = sym('b');
Intervalo = [xmin, xmax, ymin, ymax];
num = sym(eval(get(handles.Num,'String'))); %Numerador de la función
denom = sym(eval(get(handles.Denom,'String'))); %denominador de la función
%CEROS DEL DENOMINADOR START
try 
    NoDom = solve(denom); %Excepciones del dominio
catch exception
    NoDom = 'NO!'
end
if(NoDom~='NO!')
    for n=1:length(NoDom)
        if(~isreal(NoDom(n)))
            NoDom(n) = 'remove'; %marco las soluciones imaginarias para eliminarlas de los puntos excluidos del dominio
        end
    end
    NoDom = NoDom(NoDom~='remove');
end
%CEROS DEL DENOMINADOR STOP
%CEROS DEL NUMERADOR START
try 
    Raices = solve(num); %Excepciones del dominio
catch exception
    Raices = 'NO!'
end
if(Raices~='NO!')
    for n=1:length(Raices)
        if(~isreal(Raices(n)))
            Raices(n) = 'remove'; %marco las soluciones imaginarias para eliminarlas de los puntos excluidos del dominio
        end
    end
    Raices = Raices(Raices~='remove');
end
Raices = unique(Raices); %Elimino los valores repetidos
NoDom = unique(NoDom);
Evitables = intersect(Raices,NoDom);
Raices = setxor(Raices,Evitables);
if (~isempty(NoDom))
    txtaux = mat2str(double(NoDom)); %Lo genera con []
    txtaux = txtaux(txtaux~='['); %los saco
    txtaux = txtaux(txtaux~=']');
    str = horzcat('Dom = R - {',txtaux,'}');
else
    str = 'Dom = R';
end
if (~isempty(Raices))
    txtaux = mat2str(double(Raices)); %Lo genera con []
    txtaux = txtaux(txtaux~='['); %los saco
    txtaux = txtaux(txtaux~=']');
    str = [str,{horzcat('Raices = {',txtaux,'}')}];
else
   str = [str,{'Raices = Vacío'}];
end

f = eval(num/denom)
m = limit(f/x,x,Inf); %Si m = 0 A.H., si m != 0 y m pertenece a reales A.O.
calcular = 1;
if (m == Inf) %No hay asíntotas horizontales ni oblicuas
    %set(handles.info,'String','La función no tiene Asíntota Oblicua ni Horizontal');
    str = [str,{'La función no tiene Asíntota Oblicua ni Horizontal'}];
    calcular = 0;
elseif m == 0 %la asíntota es Horizontal
    %set(handles.info,'String','La asíntota es horizontal');
    str = [str,{'La asíntota es horizontal'}];
else %la Asíntota es oblicua
    %set(handles.info,'String','La asíntota es oblicua');
    str = [str,{'La asíntota es oblicua'}];
end
if (calcular)
    b = limit(f-m*x,x,Inf); %calculo de b (si m = 0 es la A.H.)
    y = m*x+b; %creo la función asíntota H ó O
end
if (strcmp(NoDom,'NO!'))
    %str = get(handles.info,'String');
    str = [str,{'Sin Asíntotas Verticales'}]
    %set(handles.info,'String',str);
else
    flag_asint = 0;
    i = 1;
    for (n = 1:length(NoDom)) %busco que excepciones del dominio son A.V.

        aux = limit(f,x,NoDom(n));
        if (isnan(aux))%Si hay asíntota vertical
            if (flag_asint)%Si no es la primera vez que entro
                if (x_asint(i-1) ~= NoDom(n)) %Solo guardo los valores que no estén (descarto raíces dobles)
                    x_asint(i) = NoDom(n);%Agrego el valor de la asintota vertical a la lista
                    i = i+1;
                end
            else %Si entro por primera vez, si o si ese valor va
                x_asint(i) = NoDom(n);%Agrego el valor de la asintota vertical a la lista
                i = i+1;
                flag_asint = 1;
            end
                
        end
    end 
end

if(handles.flag_hold == 0)
    cla; %reseteo todos los ejes
end
switch (handles.color) %traduzco el color solicitado para el gráfico
    case 'Azul'
        handles.color = 'b';
    case 'Rojo'
        handles.color = 'r';
    case 'Verde'
        handles.color = 'g';
    case 'Amarillo'
        handles.color = 'y';
    case 'Magenta'
        handles.color = 'm';
    case 'Cian'
        handles.color = 'c';
    case 'Negro'
        handles.color = 'k';
end
switch (handles.color_asint) %traduzco el color solicitado para asíntotas
    case 'Azul'
        handles.color_asint = 'b';
    case 'Rojo'
        handles.color_asint = 'r';
    case 'Verde'
        handles.color_asint = 'g';
    case 'Amarillo'
        handles.color_asint = 'y';
    case 'Magenta'
        handles.color_asint = 'm';
    case 'Cian'
        handles.color_asint = 'c';
    case 'Negro'
        handles.color_asint = 'k';
end
handles.estilo_asint
switch (handles.estilo_asint)
    case 'Rayada'
        handles.estilo_asint = '--';
    case 'Sólida'
        handles.estilo_asint = '-';
    case 'Punteada'
        handles.estilo_asint = ':';
end
handles.estilo_asint
line([xmin xmax],[0 0],'Color','k','LineWidth',2);
hold on;
line([0 0],[ymin ymax],'Color','k','LineWidth',2);
if (isnumeric(f))%Si pusieron algo que es simplemente un número
    line([xmin xmax],[f f],'Color',handles.color,'LineWidth',2);
    set(handles.info,'String',[{'La función es una constante independiente de X.'},{'No posee asíntotas de ningún tipo.'}]);
else %Si f es en verdad una función de x
    num_fun = inline(vectorize(char(simplify(f))));
    X = xmin:(xmax-xmin)/1000:xmax; %Genero los valores discretos
    Y = num_fun(X);
    plot(X,Y,'LineWidth',2,'Color',handles.color);
    if(~isempty(Evitables)) %Grafico disc. evit.
        Yevit = num_fun(double(Evitables))
        double(Evitables)
        num_fun
        plot(double(Evitables),Yevit,'o','Color',handles.color,'MarkerSize',8,'MarkerFaceColor','w');
    end
    if (calcular) %Si hubo asíntota
        num_y = inline(vectorize(char(y)));
        Y1 = num_y(X);
        h = plot(X,Y1,'Color', handles.color_asint);%Grafico la Asíntota
        set(h,'LineStyle',handles.estilo_asint)
    end
    %str = get(handles.info,'String');
    if (flag_asint)
        str = [str,{'Asíntotas verticales en los valores X = '},{num2str(double(x_asint))}];
        for n = 1:length(x_asint)
            line([x_asint(n) x_asint(n)],[ymin ymax],'LineStyle',handles.estilo_asint,'Color', handles.color_asint); 
        end
    else
        str = [str,{'Sin Asíntotas Verticales'}];   
    end
    if (calcular)
        str = [str,{'Ecuación de la Asíntota'},{horzcat('y = ',char(y))}];
    end
    if (~isempty(Evitables))
        txtaux = mat2str(double(Evitables)); %Lo genera con []
        txtaux = txtaux(txtaux~='['); %los saco
        txtaux = txtaux(txtaux~=']');
        str = [str,{horzcat('Discontinuidad Evitable en X = ',txtaux)}];
    end
    set(handles.info,'String',str);
    
end
grid on;
set(handles.tog_grilla,'Value',1);
set(handles.tog_grilla,'String','Desactivar Grilla');
axis(Intervalo);      
'END!!'



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_setaxes.
function btn_setaxes_Callback(hObject, eventdata, handles)
% hObject    handle to btn_setaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% xmin = str2num(get(handles.edit_xmin,'String'));
% xmax = str2num(get(handles.edit_xmax,'String'));
% ymin = str2num(get(handles.edit_ymin,'String'));
% ymax = str2num(get(handles.edit_ymax,'String'));
% Intervalo = [xmin, xmax, ymin, ymax];
% axis(Intervalo); 
pushbutton1_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in chk_holdgraf.
function chk_holdgraf_Callback(hObject, eventdata, handles)
% hObject    handle to chk_holdgraf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_holdgraf
handles.flag_hold = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function chk_holdgraf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chk_holdgraf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.flag_hold = 0;
guidata(hObject,handles);


% --- Executes on selection change in pop_color.
function pop_color_Callback(hObject, eventdata, handles)
% hObject    handle to pop_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'Value');
lista = get(hObject,'String');
handles.color = lista{val};%Asigno el string que corresponde al valor de color.
guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns pop_color contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_color


% --- Executes during object creation, after setting all properties.
function pop_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
val = get(hObject,'Value');
lista = get(hObject,'String');
handles.color = lista{val};%Asigno el string que corresponde al valor de color.
guidata(hObject,handles);


% --- Executes on selection change in pop_colorasint.
function pop_colorasint_Callback(hObject, eventdata, handles)
% hObject    handle to pop_colorasint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_colorasint contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_colorasint
val = get(hObject,'Value');
lista = get(hObject,'String');
handles.color_asint = lista{val};%Asigno el string que corresponde al valor de color.
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function pop_colorasint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_colorasint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
val = get(hObject,'Value');
lista = get(hObject,'String');
handles.color_asint = lista{val};%Asigno el string que corresponde al valor de color.
guidata(hObject,handles);

% --- Executes on selection change in pop_estilo.
function pop_estilo_Callback(hObject, eventdata, handles)
% hObject    handle to pop_estilo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_estilo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_estilo
val = get(hObject,'Value');
lista = get(hObject,'String');
handles.estilo_asint = lista{val};%Asigno el string que corresponde al valor de color.
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function pop_estilo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_estilo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
val = get(hObject,'Value');
lista = get(hObject,'String');
handles.estilo_asint = lista{val};%Asigno el string que corresponde al valor de color.
guidata(hObject,handles);


% --- Executes on button press in tog_grilla.
function tog_grilla_Callback(hObject, eventdata, handles)
% hObject    handle to tog_grilla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch (get(hObject,'Value'))
    case 0
        grid off
        set(hObject,'String','Activar Grilla');
    case 1
        grid on
        set(hObject,'String','Desactivar Grilla');
end
% Hint: get(hObject,'Value') returns toggle state of tog_grilla


% --- Executes on button press in btn_clear.
function btn_clear_Callback(hObject, eventdata, handles)
% hObject    handle to btn_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
