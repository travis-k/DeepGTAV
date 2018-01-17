clc
clear

% Creating the first two messages, the same as the python code
len_bytes = "b'\x7f\x00\x00\x00'"
out_msg = "b'{""start"": {""scenario"": {""location"": null, ""time"": null, ""vehicle"": null, ""drivingMode"": -1, ""weather"": null}, ""dataset"": null}}'"

% Connecting to the game
t = tcpip('localhost',8000);
t.OutputBufferSize = 3000;

fopen(t);

% Sending the start messages
fprintf(t, '%s\n', len_bytes);
fprintf(t, '%s\n', string(out_msg));

% Creating and sending the stop message
len_bytes = "b'\x0e\x00\x00\x00'"
out_msg = "b'{""stop"": null}'"
fprintf(t, '%s\n', len_bytes);
fprintf(t, '%s\n', string(out_msg));

fclose(t);
delete(t)
clear t

% scenario.location = [1015.6 736.8];
% scenario.time = [22, 0];
% scenario.weather = "RAIN";
% scenario.vehicle = [];
% scenario.drivingMode = [1074528293 15];

% dataset.rate = 20;
% dataset.frame = [227 227];
% dataset.vehicles = "true";
% dataset.peds = "false";
% dataset.trafficSigns = [];
% dataset.direction = [1234.8, 354.3, 0];
% dataset.reward = [15.0 0.5];
% dataset.throttle = "true";
% dataset.brake = "true";
% dataset.steering = "true";
% dataset.speed = [];
% dataset.yawRate = "false";
% dataset.drivingMode = [];
% dataset.location = [];
% dataset.time = "false";   

% out.start.scenario = scenario;
% out.start.dataset = dataset;

% start_msg = jsonencode(out);
% len_bytes = getSize(start_msg);

% function [ bytes ] = getSize( variable )
% props = properties(variable); 
% if size(props, 1) < 1, bytes = whos(varname(variable)); bytes = bytes.bytes;
% else %code of Dmitry
%   bytes = 0;
%   for ii=1:length(props)
%       currentProperty = getfield(variable, char(props(ii)));
%       s = whos(varname(currentProperty));
%       bytes = bytes + s.bytes;
%   end
% end
% end
% 
% function [ name ] = varname( ~ )
% name = inputname(1);
% end