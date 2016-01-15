function varargout = OFET_GUI(varargin)
% OFET_GUI MATLAB code for OFET_GUI.fig
%      OFET_GUI, by itself, creates a new OFET_GUI or raises the existing
%      singleton*.
%
%      H = OFET_GUI returns the handle to a new OFET_GUI or the handle to
%      the existing singleton*.
%
%      OFET_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OFET_GUI.M with the given input arguments.
%
%      OFET_GUI('Property','Value',...) creates a new OFET_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OFET_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OFET_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OFET_GUI

% Last Modified by GUIDE v2.5 15-Jan-2016 16:17:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OFET_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @OFET_GUI_OutputFcn, ...
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


% --- Executes just before OFET_GUI is made visible.
function OFET_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OFET_GUI (see VARARGIN)

addpath('Data');
addpath('Functions');
addpath('Papers');

%Initialize handes.PlotIndVar to Mn
handles.PlotIndVar = 'Mn'

%Initialize invisble option submenus
handles.List_SubsTreat.Visible='off'
handles.Mn_Min.Visible='off'
handles.Mn_Max.Visible='off'
handles.PDI_Min.Visible='off'
handles.PDI_Max.Visible='off'
handles.InitConc_Min.Visible='off'
handles.InitConc_Max.Visible='off'
handles.List_Solv.Visible='off'
handles.Check_Spin.Visible='off'
handles.Check_Drop.Visible='off'
handles.Check_Dip.Visible='off'

% %Initialize Default Max to Infinity
% handles.Mn_Max.Value=Inf
% handles.PDI_Max.Value=Inf
% handles.InitConc_Max.Value=Inf
% 
% %Initialize Default Min to 0
% handles.Mn_Min.Value=0
% handles.PDI_Min.Value=0
% handles.InitConc_Min.Value=0



%Initialize Constants
load('OFETDatabase.mat')
ProcVars = fieldnames(OFET);
handles.Constants=cell2struct(cell(size(ProcVars)), ProcVars, 1);

% Choose default command line output for OFET_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OFET_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 

handles.PlotIndVar=get(hObject,'Tag')
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = OFET_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%% Plot Button Controls %%%%%%%%%%
        % --- Executes on button press in Plot.
        function Plot(hObject, eventdata, handles)
        % hObject    handle to Plot (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        [MobSort, GroupSort, Filtered] = OFETSearch(handles.Constants,handles.PlotIndVar);

%         [hScat,hMarks,ax] = GoodBox(GroupSort,MobSort);
        guidata(hObject, handles);

        % --- Executes on button press in Mn.
        function Mn_Callback(hObject, eventdata, handles)
        % hObject    handle to Mn (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        % Hint: get(hObject,'Value') returns toggle state of Mn

        if (get(hObject,'Value') == get(hObject,'Max'))
            handles.PlotIndVar = 'Mn';
        end
        guidata(hObject, handles);
        %%%%%%%%%% Plot Button Controls %%%%%%%%%%



%%%%%%%%%% Surface Treatment Controls %%%%%%%%%%
        % --- Executes on button press in Check_SubsTreat.
        function Check_SubsTreat_Callback(hObject, eventdata, handles)
        % hObject    handle to Check_SubsTreat (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        if (get(hObject,'Value') == get(hObject,'Max'))
            handles.List_SubsTreat.Visible='on'
        else
            handles.Constants.SubsTreat=[];
            handles.List_SubsTreat.Visible='off'
        end

        % Hint: get(hObject,'Value') returns toggle state of Check_SubsTreat
        guidata(hObject, handles);
        
        % --- Executes on selection change in List_SubsTreat.
        function List_SubsTreat_Callback(hObject, eventdata, handles)
        % hObject    handle to List_SubsTreat (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        full_list=cellstr(get(handles.List_SubsTreat, 'String'))
        select_val = get(handles.List_SubsTreat,'Value')
        handles.Constants.SubsTreat=full_list(select_val)

        % Hints: contents = cellstr(get(hObject,'String')) returns List_SubsTreat contents as cell array
        %        contents{get(hObject,'Value')} returns selected item from List_SubsTreat
        guidata(hObject, handles);
%%%%%%%%%% Surface Treatment Controls %%%%%%%%%%

%%%%%%%%%% Mn Controls %%%%%%%%%%
        function Check_Mn_Callback(hObject, eventdata, handles)
        % hObject    handle to Check_Mn (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        if (get(hObject,'Value') == get(hObject,'Max'))
            handles.Mn_Min.Visible='on'
            handles.Mn_Max.Visible='on'
        else
            handles.Constants.Mn=[];
            handles.Mn_Min.Visible='off'
            handles.Mn_Max.Visible='off'
        end

        % Hint: get(hObject,'Value') returns toggle state of Check_Mn
        guidata(hObject, handles);

        function Mn_Min_Callback(hObject, eventdata, handles)
        % hObject    handle to Mn_Min (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        Max=str2double(get(handles.Mn_Max,'String'))
        Min=str2double(get(handles.Mn_Min, 'String'))
        
        if isnan(Max)==1
            Max=Inf
        end
        if isnan(Min)==1
            Min=0
        end
        
        handles.Constants.Mn=[Min Max]
        % Hints: get(hObject,'String') returns contents of Mn_Min as text
        %        str2double(get(hObject,'String')) returns contents of Mn_Min as a double
        guidata(hObject, handles);

        function Mn_Max_Callback(hObject, eventdata, handles)
        % hObject    handle to Mn_Max (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        Max=str2double(get(handles.Mn_Max,'String'))
        Min=str2double(get(handles.Mn_Min, 'String'))
          if isnan(Max)==1
            Max=Inf
        end
        if isnan(Min)==1
            Min=0
        end
        handles.Constants.Mn=[Min Max]
        % Hints: get(hObject,'String') returns contents of Mn_Max as text
        %        str2double(get(hObject,'String')) returns contents of Mn_Max as a double
        guidata(hObject, handles);
%%%%%%%%%% Mn Controls %%%%%%%%%%

%%%%%%%%%% PDI Controls %%%%%%%%%%
        % --- Executes on button press in Check_PDI.
        function Check_PDI_Callback(hObject, eventdata, handles)
        % hObject    handle to Check_PDI (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        if (get(hObject,'Value') == get(hObject,'Max'))
            handles.PDI_Min.Visible='on'
            handles.PDI_Max.Visible='on'
        else
            handles.Constants.PDI=[];
            handles.PDI_Min.Visible='off'
            handles.PDI_Max.Visible='off'
        end

        % Hint: get(hObject,'Value') returns toggle state of Check_PDI
        guidata(hObject, handles);

        function PDI_Max_Callback(hObject, eventdata, handles)
        % hObject    handle to PDI_Max (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        Max=str2double(get(handles.PDI_Max,'String'))
        Min=str2double(get(handles.PDI_Min, 'String'))
        
        if isnan(Max)==1
            Max=Inf
        end
        if isnan(Min)==1
            Min=0
        end
        
        handles.Constants.PDI=[Min Max]
        % Hints: get(hObject,'String') returns contents of PDI_Max as text
        %        str2double(get(hObject,'String')) returns contents of PDI_Max as a double
        guidata(hObject, handles);
        
        function PDI_Min_Callback(hObject, eventdata, handles)
        % hObject    handle to PDI_Min (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        Max=str2double(get(handles.PDI_Max,'String'))
        Min=str2double(get(handles.PDI_Min, 'String'))
         if isnan(Max)==1
            Max=Inf
        end
        if isnan(Min)==1
            Min=0
        end
        handles.Constants.PDI=[Min Max]
        % Hints: get(hObject,'String') returns contents of PDI_Min as text
        %        str2double(get(hObject,'String')) returns contents of PDI_Min as a double
        guidata(hObject, handles);
%%%%%%%%%% PDI Controls %%%%%%%%%%

%%%%%%%%%% InitConc Controls %%%%%%%%%%
% --- Executes on button press in Check_InitConc.
        function Check_InitConc_Callback(hObject, eventdata, handles)
        % hObject    handle to Check_InitConc (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
                if (get(hObject,'Value') == get(hObject,'Max'))
                    handles.InitConc_Min.Visible='on'
                    handles.InitConc_Max.Visible='on'
                else
                    handles.Constants.InitConc=[];
                    handles.InitConc_Min.Visible='off'
                    handles.InitConc_Max.Visible='off'
                end
        % Hint: get(hObject,'Value') returns toggle state of Check_InitConc

        guidata(hObject, handles);

        function InitConc_Max_Callback(hObject, eventdata, handles)
        % hObject    handle to InitConc_Max (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        Max=str2double(get(handles.InitConc_Max,'String'))
                Min=str2double(get(handles.InitConc_Min, 'String'))
                 if isnan(Max)==1
            Max=Inf
        end
        if isnan(Min)==1
            Min=0
        end
                handles.Constants.InitConc=[Min Max]
        % Hints: get(hObject,'String') returns contents of InitConc_Max as text
        %        str2double(get(hObject,'String')) returns contents of InitConc_Max as a double
        guidata(hObject, handles);

        function InitConc_Min_Callback(hObject, eventdata, handles)
        % hObject    handle to InitConc_Min (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        Max=str2double(get(handles.InitConc_Max,'String'))
         if isnan(Max)==1
            Max=Inf
        end
        if isnan(Min)==1
            Min=0
        end
                Min=str2double(get(handles.InitConc_Min, 'String'))
                handles.Constants.InitConc=[Min Max]
        % Hints: get(hObject,'String') returns contents of InitConc_Min as text
        %        str2double(get(hObject,'String')) returns contents of InitConc_Min as a double
        guidata(hObject, handles)
%%%%%%%%%% InitConc Controls %%%%%%%%%%

%%%%%%%%%% Solvent Controls %%%%%%%%%%
        % --- Executes on button press in Check_Solv.
        function Check_Solv_Callback(hObject, eventdata, handles)
        % hObject    handle to Check_Solv (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
                if (get(hObject,'Value') == get(hObject,'Max'))
                    handles.List_Solv.Visible='on'
                else
                    handles.Constants.SubsTreat=[];
                    handles.List_Solv.Visible='off'
                end
        % Hint: get(hObject,'Value') returns toggle state of Check_Solv
        guidata(hObject, handles)

        % --- Executes on selection change in List_Solv.
        function List_Solv_Callback(hObject, eventdata, handles)
        % hObject    handle to List_Solv (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
                full_list=cellstr(get(handles.List_Solv, 'String'))
                select_val = get(handles.List_Solv,'Value')
                a=full_list(select_val)
                handles.Constants.Solv1=full_list(select_val)
                
        % Hints: contents = cellstr(get(hObject,'String')) returns List_Solv contents as cell array
        %        contents{get(hObject,'Value')} returns selected item from List_Solv

        guidata(hObject, handles)
%%%%%%%%%% Solvent Controls %%%%%%%%%%

%%%%%%%%%% Deposition Methods Controls %%%%%%%%%%

        function Check_Depo_Callback(hObject, eventdata, handles)
        % hObject    handle to Check_Depo (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        if (get(hObject,'Value') == get(hObject,'Max'))
                            handles.Check_Spin.Visible='on'
                            handles.Check_Drop.Visible='on'
                            handles.Check_Dip.Visible='on'
                        else
                            handles.Constants.Depo=[];
                            handles.Check_Spin.Visible='off'
                            handles.Check_Drop.Visible='off'
                            handles.Check_Dip.Visible='off'
                        end
        % Hint: get(hObject,'Value') returns toggle state of Check_Depo
        guidata(hObject, handles)

% --- Executes on button press in Check_Spin.
function Check_Spin_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Spin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  if (get(handles.Check_Spin,'Value') == get(handles.Check_Spin,'Max'))
      Opt1={'SPUN'}
  else Opt1={}
  end
  
  if (get(handles.Check_Drop,'Value') == get(handles.Check_Drop,'Max'))
      Opt2={'DROPPED'}
      else Opt2={}
  end
  if (get(handles.Check_Dip,'Value') == get(handles.Check_Dip,'Max'))
      Opt3={'DIPPED'}
      else Opt3={}
  end
 
      handles.Constants.Depo=[Opt1; Opt2; Opt3]
% Hint: get(hObject,'Value') returns toggle state of Check_Spin
guidata(hObject, handles)

% --- Executes on button press in Check_Drop.
function Check_Drop_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Drop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  if (get(handles.Check_Spin,'Value') == get(handles.Check_Spin,'Max'))
      Opt1={'SPUN'}
  else Opt1={}
  end
  
  if (get(handles.Check_Drop,'Value') == get(handles.Check_Drop,'Max'))
      Opt2={'DROPPED'}
      else Opt2={}
  end
  if (get(handles.Check_Dip,'Value') == get(handles.Check_Dip,'Max'))
      Opt3={'DIPPED'}
      else Opt3={}
  end
 
      handles.Constants.Depo=[Opt1; Opt2; Opt3]
% Hint: get(hObject,'Value') returns toggle state of Check_Drop
guidata(hObject, handles)

% --- Executes on button press in Check_Dip.
function Check_Dip_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Dip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  if (get(handles.Check_Spin,'Value') == get(handles.Check_Spin,'Max'))
      Opt1={'SPUN'}
  else Opt1={}
  end
  
  if (get(handles.Check_Drop,'Value') == get(handles.Check_Drop,'Max'))
      Opt2={'DROPPED'}
      else Opt2={}
  end
  if (get(handles.Check_Dip,'Value') == get(handles.Check_Dip,'Max'))
      Opt3={'DIPPED'}
      else Opt3={}
  end
 
      handles.Constants.Depo=[Opt1; Opt2; Opt3]
% Hint: get(hObject,'Value') returns toggle state of Check_Dip
guidata(hObject, handles)
%%%%%%%%%% Deposition Methods Controls %%%%%%%%%%







% --- Executes during object creation, after setting all properties.
function List_SubsTreat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to List_SubsTreat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Mn_Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mn_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Mn_Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mn_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function PDI_Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PDI_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function PDI_Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PDI_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function InitConc_Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InitConc_Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes during object creation, after setting all properties.
function InitConc_Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InitConc_Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function List_Solv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to List_Solv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
