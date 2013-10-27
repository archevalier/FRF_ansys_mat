function Comp2Fig(varargin)
%比较已经生成的fig图
%将档案存在搜寻目录或工作目录上,只要在command win输入Comp2Fig即可
% Comp2Fig - Combine 2 figure for comparison.
%
% Comp2Fig or Comp2Fig(hFig1,hFig2)
%
% hFig1 : input figure handle for base (empty for user selection)
% hFig2 : input figure handle for other (empty for user selection)
% *** No output arguments, input is optinal select


% Ckeck the input & output property
PreS = [blanks(10),'*** Error : ']; EndS = ' ! <== Comp2Fig ***'; PreW = [blanks(5),'*** '];
if nargin > 2, error([PreS,'No more 3 input arguments',EndS]); end
if nargout > 0, error([PreS,'No any output arguments',EndS]); end

hFig1 = []; hFig2 = []; DefName = '';
if nargin >= 1, hFig1 = varargin{1}; if nargin >= 2, hFig2 = varargin{2}; end; end

% Begin the figure comparison process
% read the base figure
if isempty(hFig1)
   TitleS = 'Choise the base file for figure combining (Cancel to Quit from Comp2Fig) :';
   beep; [FileName1,PathName] = uigetfile('*.fig',TitleS);
   if FileName1==0, beep; disp([PreW,'File not ready ?',EndS]); return; % abort action
   else cd(PathName); end % change directory
   try open(FileName1); hFig1 = gcf; catch, disp(['Open File Error!',EndS]); return; end;
   DefName = FileName1;
end; hAxes1=get(hFig1,'Children'); pause(0.5);

% read the another figure
if isempty(hFig2)
   TitleS = 'Choise the other file for figure combining (Cancel to Quit from Comp2Fig) :';
   beep; [FileName2,PathName] = uigetfile('*.fig',TitleS);
   if FileName2==0, beep; disp([PreW,'File not ready ?',EndS]); return; % abort action
   else cd(PathName); end % change directory
   try open(FileName2); hFig2 = gcf; catch, disp(['Open File Error!',EndS]); return; end
end; hAxes2=get(hFig2,'Children');

% compare 2 figure
for m = 1:length(hAxes2)
   LColor=get(hAxes1(m),'ColorOrder'); iLine=0;
   hLine1 = get(hAxes1(m),'Children');
   for K=length(hLine1):-1:1, if strcmp(get(hLine1(K),'Type'),'line'), iLine=iLine+1; end; end
   hLine2 = get(hAxes2(m),'Children');
   for K=length(hLine2):-1:1, if strcmp(get(hLine2(K),'Type'),'line')
      xp = get(hLine2(K),'XData'); yp = get(hLine2(K),'YData'); iLine=iLine+1;
      figure(hFig1); set(hFig1,'CurrentAxes',hAxes1(m)); grid on; hold on;
      hhn=plot(xp,yp); set(hhn,'Color',LColor(mod(iLine,7)+1,:)); axis auto;
   end; end
   xlabel( get( get(hAxes2(m),'XLabel'), 'String') );
   ylabel( get( get(hAxes2(m),'YLabel'), 'String') );
end

% save the combine figure
pause(0.5);
TitleS = 'Filename for saveing plot (Cancel to not save) :';
beep; [FileName3,PathName3] = uiputfile(DefName,TitleS);
if FileName3==0, FileName3=[]; end % abort the save file action
if ~isempty(FileName3), 
   try saveas(hFig1,[PathName3,FileName3]);
   catch, saveas(hFig1,[PathName3,strtok(FileName3,'.')],'fig'); end
end
close(hFig2);

% no output arguments definition
beep; disp([PreW,'Function is complete',EndS]);
return
