function [Density,Mass,Volume,Surface_Area,Center_of_Mass,P, Moment_of_Intertia] = Jake_Helper(filepath)
%Function to Parse .docx output of solidworks.
%   You'll need to flesh this out with what you need. For every 
% output you want, you'll add it to the bottom list as well as the first
% line.

%start up needed package
word = actxserver('Word.Application');

%Opens word document
wdoc = word.Documents.Open(filepath);

%Reads document into a long character string saved to 'sometext'
sometext = wdoc.Content.Text;

%Parse character string by spaces, use second listed function to parse by
%spaces and arrows... make changes as needed
sometext = strsplit(sometext,' ')

%Create a bunch of variables for the shit you need. For example, element
% 14 of sometext is where density is stored. Once you create a variable,
% add it to the output at the very top line. 
Density = str2double(string(sometext(14)));
Mass    = str2double(string(sometext(20)));
Volume  = str2double(string(sometext(23)));
Surface_Area = str2double(string(sometext(28)));

X = char(sometext(37));
X = str2double(X(1:4));

Y = char(sometext(39));
Y = str2double(Y(1:5));

Z = char(sometext(41));
Z = str2double(Z(1:4));

Center_of_Mass = [X;Y;Z];

Ix1 = char(sometext(64));
Ix1 = str2double(Ix1(1:4));
Ix2 = char(sometext(65));
Ix2 = str2double(Ix2(1:4));
Ix3 = char(sometext(66));
Ix3 = str2double(Ix3(1:4));

Ix = [Ix1, Ix2, Ix3];

Iy1 = char(sometext(73));
Iy1 = str2double(Iy1(1:4));
Iy2 = char(sometext(74));
Iy2 = str2double(Iy2(1:4));
Iy3 = char(sometext(75));
Iy3 = str2double(Iy3(1:4));

Iy = [Iy1, Iy2, Iy3];

Iz1 = char(sometext(82));
Iz1 = str2double(Iz1(1:4));
Iz2 = char(sometext(83));
Iz2 = str2double(Iz2(1:4));
Iz3 = char(sometext(84));
Iz3 = str2double(Iz3(1:4));

Iz = [Iz1, Iz2, Iz3];

Px = char(sometext(69));
Px = str2double(Px(1:8));

Py = char(sometext(78));
Py = str2double(Py(1:8));

Pz = char(sometext(87));
Pz = str2double(Pz(1:8));

P  = [Ix, Px; Iy, Py; Iz, Pz];


end

