-record(user, {id,name, pwd="123456"}).

%% rr("records.hrl").
%% Tom = #user{name="tom"}.
%% #user{name=Name} = Tom.
%% Name = Tom#user.name.
%% Name.  
%% 
%% Andy = Tom#user{name="andy"}.  
%% 
%% is_record(X, user)
%% 
%% rf(user)
%% 
%% 记录只是元组的伪装
