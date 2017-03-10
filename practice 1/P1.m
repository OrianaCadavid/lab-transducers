function varargout = P1(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P1_OpeningFcn, ...
                   'gui_OutputFcn',  @P1_OutputFcn, ...
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


function plotWaves(handles)
idx = get(handles.func, 'Value');
fm = str2num(get(handles.samplerate, 'String'));
A = str2num(get(handles.amp, 'String'));
f = str2num(get(handles.freq, 'String'));
off = str2num(get(handles.offset, 'String'));
n = str2num(get(handles.N, 'String')); 
T = n / fm;

t = 0 : 1 / fm : T - (1 / fm);

if idx == 1
    axes(handles.axes1);
    y = A .* sin(2 * pi * f * t) + off;
    plot(t, y);
    xlabel('Tiempo (t)');
    ylabel('Voltaje (V)', 'Rotation', 90);
    grid on;
    
    % Transformada de Fourier 
    %Calibraci�n del eje de frecuencias:
    NFFT = 4^nextpow2(n);
    Y = fft(y, NFFT) / n;
    f1 = fm / 2 * linspace(0, 1 ,NFFT / 2 + 1);
    
    axes(handles.axes2);
    plot(f1, 2 * abs(Y(1: NFFT / 2 + 1)));
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    grid on;
   
    
    % Valor promedio de la se�al:
    l = 0; 
    for m = 0 : 1 / fm : T-(1 / fm)
        Vprom = (A * sin((2 * pi) * (f * m))+ off) + l;
        l = Vprom;
    end
    
    Vpromedio = Vprom / n;
    set(handles.average, 'String', num2str(Vpromedio))
    
    % Valor RMS de la se�al:
    k = 0;
    for i = 0 : 1 / fm : T-(1 / fm)
       V = ((A * sin((2 * pi) * (f * i)))+ off)^(2) + k;
       k = V;
    end
    
    Vrms = sqrt(V / n);
    set(handles.RMS, 'String', num2str(Vrms))
    
elseif idx == 2
    axes(handles.axes1);
    y = A .* square(2 * pi * f * t)+off;
    plot(t, y);
    xlabel('Tiempo (t)');
    ylabel('Voltaje (V)', 'Rotation', 90);
    grid on;
    
    % Transformada de Fourier 
    % Calibraci�n del eje de frecuencias:
    NFFT = 4^nextpow2(n); 
    Y = fft(y, NFFT)/n;
    f1 = fm / 2 * linspace(0, 1, NFFT / 2 + 1);
       
    
    axes(handles.axes2);
    plot(f1, 2 * abs(Y(1:NFFT/2+1)));
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    grid on;
    
    % Valor promedio de la se�al:
    l = 0; 
    for m = 0 : 1 / fm : T-(1 / fm)
        Vprom = (A * square((2 * pi) * (f * m)) + off) + l;
        l = Vprom;
    end
    
    Vpromedio = Vprom / n;
    set(handles.average, 'String', num2str(Vpromedio))
    
    % Valor RMS de la se�al:
    k = 0;
    for i = 0 : 1 / fm : T-(1 / fm)
       V = ((A * square((2 * pi) * (f * i)))+ off)^(2) + k;
       k = V;
    end
    
    Vrms = sqrt(V / n);
    set(handles.RMS, 'String', num2str(Vrms))
    
    
else
    axes(handles.axes1);
    y = A .* sawtooth((2 * pi * f * t) , 0.5 ) + off;
    plot(t, y);
    xlabel('Tiempo (t)');
    ylabel('Voltaje (V)', 'Rotation', 90);
    grid on;
    
    % Transformada de Fourier 
    %Calibraci�n del eje de frecuencias:
    NFFT = 4^nextpow2(n); 
    Y = fft(y, NFFT) / n;
    f1 = fm / 2 * linspace(0, 1, NFFT / 2 + 1);
       
    axes(handles.axes2);
    plot(f1, 2 * abs(Y(1:NFFT/2+1)));
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    grid on;
    
     % Valor promedio de la se�al:
    l = 0; 
    for m = 0 : 1 / fm : T-(1 / fm)
        Vprom = (A * sawtooth((2 * pi) * (f * m))+ off) + l;
        l = Vprom;
    end
    
    Vpromedio = Vprom / n;
    set(handles.average, 'String', num2str(Vpromedio))
    
    % Valor RMS de la se�al:
    k = 0;
    for i = 0 : 1 / fm : T-(1 / fm)
       V = ((A * sawtooth((2 * pi) * (f * i)))+ off)^(2) + k;
       k = V;
    end
    
    Vrms = sqrt(V / n);
    set(handles.RMS, 'String', num2str(Vrms))
    
end


function P1_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;


guidata(hObject, handles);



function varargout = P1_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function func_Callback(hObject, eventdata, handles)

plotWaves(handles);


function func_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_Callback(hObject, eventdata, handles)

plotWaves(handles);



function amp_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freq_Callback(hObject, eventdata, handles)

plotWaves(handles);


function freq_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function offset_Callback(hObject, eventdata, handles)

plotWaves(handles);


function offset_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function samplerate_Callback(hObject, eventdata, handles)
% samplerate as a double
plotWaves(handles);

function samplerate_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function N_Callback(hObject, eventdata, handles)
plotWaves(handles);



function N_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function axes1_CreateFcn(hObject, eventdata, handles)
axes(hObject); 
grid on;


function average_Callback(hObject, eventdata, handles)



function average_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RMS_Callback(hObject, eventdata, handles)


function RMS_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function axes2_CreateFcn(hObject, eventdata, handles)
axes(hObject);
grid on;
