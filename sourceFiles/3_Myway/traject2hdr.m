function [path] = traject2hdr(signal,folder,file,array_name)
%REF2HDR Export reference vector to c# myway header file.
%   [path] = traject2hdr(signal,folder,file,array_name)
% signal    : reference vector
% folder    : subfolder from current path
% file      : name of header file, required format: R...ref.h
% array_name: name of array
% Algorithm : low level file I/O to create header for
%             MyWay PE-Expert3 system (MWPE-C6713A DSP)
% Author    : Thomas Beauduin, University of Tokyo
%             Hori-Fujimoto lab, 08 March 2015
%%%%%

if nargin < 4
    array_name = 'refvec';
end

nrofs = size(signal,1);
fid = fopen(strcat(folder,file),'w');
%name = strrep(file,'.h','');
%array_name = strrep(name,'R','');
%nrofs_name = upper(strrep(array_name,'ref',''));
%array_name = 'refvec';
nrofs_name = 'NROFS';
fprintf(fid,'#define %s %d \n', nrofs_name, nrofs);
fprintf(fid,'far float %s [%s] = { \n',array_name,nrofs_name);

j = 0;
for i=1 : nrofs
    fprintf(fid, '%.10f, ', signal(i));
    j=j+1;
    if j == 10
        fprintf(fid, '\n'); j = 0;
    end
end
fprintf(fid,'}; \n');
fclose(fid);

path = strcat(pwd,'\',file);
end
