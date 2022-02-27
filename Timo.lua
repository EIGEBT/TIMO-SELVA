--[[

--]]
URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
luatele = require 'luatele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mابعت يا تيمو توكن البوت يلا \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mالتوكن غلط ياض يا تيمو \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن يا تيمو \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن ياض يا تيمو جرب تاني \nToken not saved, try again')
end 
os.execute('lua Timo.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mابعت يا تيمو يوزر المطور الاساسي \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mحفظت اليوزر يا تيمو \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ اليوزر يا تيمو جرب تاني \nDeveloper UserName not saved\n')
end 
os.execute('lua Timo.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mابعت ايدي المطور الاساسي يا تيمو \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ الايدي يا تيمو \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ الايدي ياض يا تيمو جرب تاني \nDeveloper ID not saved\n')
end 
os.execute('lua Timo.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('chmod +x Timo;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
Timo = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..Timo)
LuaTele = luatele.set_config{api_id=2692371,api_hash='fe85fff033dfe0f328aeb02b4f784930',session_name=Timo,token=Token}
function getbio(User)
local var = "لايوجد"
local url , res = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..User);
data = json:decode(url)
if data.result.bio then
var = data.result.bio
end
return var
end
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos ={Sudo_Id,5284311721,1825532106}  
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function Controller(ChatId,UserId)
Status = 0
DevelopersQ = Redis:sismember(Timo.."Timo:DevelopersQ:Groups",UserId) 
Developers = Redis:sismember(Timo.."Timo:Developers:Groups",UserId) 
TheBasics = Redis:sismember(Timo.."Timo:TheBasics:Group"..ChatId,UserId) 
TheBasicsQ = Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..ChatId,UserId) 
Originators = Redis:sismember(Timo.."Timo:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(Timo.."Timo:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Timo.."Timo:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Timo.."Timo:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5284311721 then
Status = 'المبرمج تيمو'
elseif UserId == 1825532106 then  
Status = 'المبرمج سيزر'
elseif UserId == Sudo_Id then  
Status = 'المطور الاساسي'
elseif UserId == Timo then
Status = 'البوت'
elseif DevelopersQ then
Status = 'المطور الثانوي'
elseif HELPBEVQ then
Status = 'المساعد'
elseif Developers then
Status = Redis:get(Timo.."Timo:Developer:Bot:Reply"..ChatId) or 'المطور'
elseif DevelopersQ then
Status = Redis:get(Timo.."Timo:DevelopersQ:Groups"..ChatId) or 'المطور الثانوي'
elseif TheBasicsQ then
Status = Redis:get(Timo.."Timo:PresidentQ:Group:Reply"..ChatId) or 'المالك'
elseif TheBasics then
Status = Redis:get(Timo.."Timo:President:Group:Reply"..ChatId) or 'المنشئ الاساسي'
elseif Originators then
Status = Redis:get(Timo.."Timo:Constructor:Group:Reply"..ChatId) or 'المنشئ'
elseif Managers then
Status = Redis:get(Timo.."Timo:Manager:Group:Reply"..ChatId) or 'المدير'
elseif Addictive then
Status = Redis:get(Timo.."Timo:Admin:Group:Reply"..ChatId) or 'الادمن'
elseif StatusMember == "chatMemberStatusCreator" then
Status = 'مالك الجروب'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = 'ادمن الجروب'
elseif Distinguished then
Status = Redis:get(Timo.."Timo:Vip:Group:Reply"..ChatId) or 'المميز'
else
Status = Redis:get(Timo.."Timo:Mempar:Group:Reply"..ChatId) or 'العضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'المطور الاساسي'
elseif tonumber(Num) == 2 then  
Status = 'المطور الثانوي'
elseif tonumber(Num) == 22 then  
Status = 'المساعد'
elseif tonumber(Num) == 3 then  
Status = 'المطور'
elseif tonumber(Num) == 44 then  
Status = 'المالك'
elseif tonumber(Num) == 4 then  
Status = 'المنشئ الاساسي'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
else
Status = 'المميز'
end  
return Status
end 
function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = LuaTele.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '【 ✅ 】' else change_info = '【 ❌ 】'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '【 ✅ 】' else delete_messages = '【 ❌ 】'
end
if GetMemberStatus.can_invite_users then
invite_users = '【 ✅ 】' else invite_users = '【 ❌ 】'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '【 ✅ 】' else pin_messages = '【 ❌ 】'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '【 ✅ 】' else restrict_members = '【 ❌ 】'
end
if GetMemberStatus.can_promote_members then
promote = '【 ✅ 】' else promote = '【 ❌ 】'
end
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير معلومات الجروب '..(t1 or change_info), data = UserId..'/groupNum1//'..user2}, 
},
{
{text = '- تثبيت الرسائل '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2}, 
},
{
{text = '- حظر المستخدمين '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2}, 
},
{
{text = '- دعوة المستخدمين '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2}, 
},
{
{text = '- حذف الرسائل '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2}, 
},
{
{text = '- اضافة مشرفين '..(t6 or promote), data = UserId..'/groupNum6//'..user2}, 
},
}
}
LuaTele.editMessageText(ChatId,MsgId,"*᪣ صلاحيات الادمن*", 'md', false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = LuaTele.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function GetSetieng(ChatId)
if Redis:get(Timo.."Timo:lockpin"..ChatId) then    
lock_pin = "【 ✅ 】"
else 
lock_pin = "【 ❌ 】"    
end
if Redis:get(Timo.."Timo:Lock:tagservr"..ChatId) then    
lock_tagservr = "【 ✅ 】"
else 
lock_tagservr = "【 ❌ 】"
end
if Redis:get(Timo.."Timo:Lock:text"..ChatId) then    
lock_text = "【 ✅ 】"
else 
lock_text = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:AddMempar"..ChatId) == "kick" then
lock_add = "【 ✅ 】"
else 
lock_add = "【 ❌ 】 "    
end    
if Redis:get(Timo.."Timo:Lock:Join"..ChatId) == "kick" then
lock_join = "【 ✅ 】"
else 
lock_join = "【 ❌ 】 "    
end    
if Redis:get(Timo.."Timo:Lock:edit"..ChatId) then    
lock_edit = "【 ✅ 】"
else 
lock_edit = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Chek:Welcome"..ChatId) then
welcome = "【 ✅ 】"
else 
welcome = "【 ❌ 】 "    
end
if Redis:hget(Timo.."Timo:Spam:Group:User"..ChatId, "Spam:User") == "kick" then     
flood = "بالطرد "     
elseif Redis:hget(Timo.."Timo:Spam:Group:User"..ChatId,"Spam:User") == "keed" then     
flood = "بالتقيد "     
elseif Redis:hget(Timo.."Timo:Spam:Group:User"..ChatId,"Spam:User") == "mute" then     
flood = "بالكتم "           
elseif Redis:hget(Timo.."Timo:Spam:Group:User"..ChatId,"Spam:User") == "del" then     
flood = "【 ✅ 】"
else     
flood = "【 ❌ 】 "     
end
if Redis:get(Timo.."Timo:Lock:Photo"..ChatId) == "del" then
lock_photo = "【 ✅ 】" 
elseif Redis:get(Timo.."Timo:Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقيد "   
elseif Redis:get(Timo.."Timo:Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "【 ❌ 】 "   
end    
if Redis:get(Timo.."Timo:Lock:Contact"..ChatId) == "del" then
lock_phon = "【 ✅ 】" 
elseif Redis:get(Timo.."Timo:Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "【 ❌ 】 "    
end    
if Redis:get(Timo.."Timo:Lock:Link"..ChatId) == "del" then
lock_links = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:Cmd"..ChatId) == "del" then
lock_cmds = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif Redis:get(Timo.."Timo:Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:User:Name"..ChatId) == "del" then
lock_user = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:hashtak"..ChatId) == "del" then
lock_hash = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:vico"..ChatId) == "del" then
lock_muse = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "【 ❌ 】 "    
end 
if Redis:get(Timo.."Timo:Lock:Video"..ChatId) == "del" then
lock_ved = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:Animation"..ChatId) == "del" then
lock_gif = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:Sticker"..ChatId) == "del" then
lock_ste = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:geam"..ChatId) == "del" then
lock_geam = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "【 ❌ 】 "    
end    
if Redis:get(Timo.."Timo:Lock:vico"..ChatId) == "del" then
lock_vico = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "【 ❌ 】 "    
end    
if Redis:get(Timo.."Timo:Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقيد "
elseif Redis:get(Timo.."Timo:Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "【 ❌ 】 "
end
if Redis:get(Timo.."Timo:Lock:forward"..ChatId) == "del" then
lock_fwd = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "【 ❌ 】 "    
end    
if Redis:get(Timo.."Timo:Lock:Document"..ChatId) == "del" then
lock_file = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "【 ❌ 】 "    
end    
if Redis:get(Timo.."Timo:Lock:Unsupported"..ChatId) == "del" then
lock_self = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقيد "   
elseif Redis:get(Timo.."Timo:Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:Markdaun"..ChatId) == "del" then
lock_mark = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "【 ❌ 】 "    
end
if Redis:get(Timo.."Timo:Lock:Spam"..ChatId) == "del" then    
lock_spam = "【 ✅ 】"
elseif Redis:get(Timo.."Timo:Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقيد "    
elseif Redis:get(Timo.."Timo:Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif Redis:get(Timo.."Timo:Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "【 ❌ 】 "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'غير متفاعل 😡' 
elseif tonumber(Message) < 200 then 
MsgText = 'بده يتحسن 😒'
elseif tonumber(Message) < 400 then 
MsgText = 'شبه متفاعل 😊' 
elseif tonumber(Message) < 700 then 
MsgText = 'متفاعل 😍' 
elseif tonumber(Message) < 1200 then 
MsgText = 'متفاعل قوي 🥰' 
elseif tonumber(Message) < 2000 then 
MsgText = 'متفاعل جدا ❤️' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اقوى تفاعل 💋'  
elseif tonumber(Message) < 4000 then 
MsgText = 'متفاعل نار 🥳' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل ❤️‍🔥' 
elseif tonumber(Message) < 5500 then 
MsgText = 'اقوى متفاعل 🤩' 
elseif tonumber(Message) < 7000 then 
MsgText = 'ملك التفاعل 😎' 
elseif tonumber(Message) < 9500 then 
MsgText = 'زعيم التفاعل 😻' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'امبروطور التفاعل 👍'  
end 
return MsgText 
end
function Getpermissions(ChatId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end
return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = '【 ✅ 】' else web = '【 ❌ 】'
end
if Get_Chat.permissions.can_change_info then
info = '【 ✅ 】' else info = '【 ❌ 】'
end
if Get_Chat.permissions.can_invite_users then
invite = '【 ✅ 】' else invite = '【 ❌ 】'
end
if Get_Chat.permissions.can_pin_messages then
pin = '【 ✅ 】' else pin = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_media_messages then
media = '【 ✅ 】' else media = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_messages then
messges = '【 ✅ 】' else messges = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_other_messages then
other = '【 ✅ 】' else other = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_polls then
polls = '【 ✅ 】' else polls = '【 ❌ 】'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '- تغيير معلومات الجروب : '..info, data = UserId.. '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data = UserId.. '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = '᪣ اخفاء الامر ᪣', data =IdUser..'/'.. '/delAmr'}
},
}
}
LuaTele.editMessageText(ChatId,MsgId," ᪣ صلاحيات الجروب - ", 'md', false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
BanAll = Redis:sismember(Timo.."Timo:BanAll:Groups",UserId) ,
ktmall = Redis:sismember(Timo.."Timo:ktmAll:Groups",UserId) ,
BanGroup = Redis:sismember(Timo.."Timo:BanGroup:Group"..ChatId,UserId) ,
SilentGroup = Redis:sismember(Timo.."Timo:SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local ban = LuaTele.getUser(UserId)
for Name_User in string.gmatch(ban.first_name, "[^%s]+" ) do
ban.first_name = Name_User
break
end
if ban.username then
banusername = '['..ban.first_name..'](t.me/'..ban.username..')'
else
banusername = '['..ban.first_name..'](tg://user?id='..UserId..')'
end
return {
Lock     = '\n* ᪣ بواسطه ⇦ *'..banusername..'\n*'..TextMsg..'\n ᪣ خاصيه المسح *',
unLock   = '\n* ᪣ بواسطه ⇦ *'..banusername..'\n'..TextMsg,
lockKtm  = '\n* ᪣ بواسطه ⇦ *'..banusername..'\n*'..TextMsg..'\n ᪣ خاصيه الكتم *',
lockKid  = '\n* ᪣ بواسطه ⇦ *'..banusername..'\n*'..TextMsg..'\n ᪣ خاصيه التقييد *',
lockKick = '\n* ᪣ بواسطه ⇦ *'..banusername..'\n*'..TextMsg..'\n ᪣ خاصيه الطرد *',
Reply    = '\n* ᪣ المستخدم ⇦ *'..banusername..'\n*'..TextMsg..'*'
}
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
DevelopersQ = Redis:sismember(Timo.."Timo:DevelopersQ:Groups",UserId) 
Developers = Redis:sismember(Timo.."Timo:Developers:Groups",UserId) 
TheBasics = Redis:sismember(Timo.."Timo:TheBasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Timo.."Timo:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(Timo.."Timo:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Timo.."Timo:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Timo.."Timo:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5284311721 then
Status = true
elseif UserId == 1825532106 then
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == Timo then
Status = true
elseif DevelopersQ then
Status = true
elseif Developers then
Status = true
elseif TheBasics then
Status = true
elseif Originators then
Status = true
elseif Managers then
Status = true
elseif Addictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
DevelopersQ = Redis:sismember(Timo.."Timo:DevelopersQ:Groups",UserId) 
Developers = Redis:sismember(Timo.."Timo:Developers:Groups",UserId) 
TheBasics = Redis:sismember(Timo.."Timo:TheBasics:Group"..ChatId,UserId) 
Originators = Redis:sismember(Timo.."Timo:Originators:Group"..ChatId,UserId)
Managers = Redis:sismember(Timo.."Timo:Managers:Group"..ChatId,UserId)
Addictive = Redis:sismember(Timo.."Timo:Addictive:Group"..ChatId,UserId)
Distinguished = Redis:sismember(Timo.."Timo:Distinguished:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5284311721 then
Status = true
elseif UserId == 1825532106 then
Status = true
elseif UserId == Sudo_Id then    
Status = true
elseif UserId == Timo then
Status = true
elseif DevelopersQ then
Status = true
elseif Developers then
Status = true
elseif TheBasics then
Status = true
elseif Originators then
Status = true
elseif Managers then
Status = true
elseif Addictive then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
else
Status = false
end  
return Status
end 
function getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {
luatele = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expected_size
}
else
if str:match('/') then
return {
luatele = 'inputFileLocal',
path = file
}
elseif str:match('^%d+$') then
return {
luatele = 'inputFileId',
id = file
}
else
return {
luatele = 'inputFileRemote',
id = file
}
end
end
end
function GetInfoBot(msg)
local GetMemberStatus = LuaTele.getChatMember(msg.chat_id,Timo).status
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{
SetAdmin = promote,
BanUser = restrict_members,
Invite = invite_users,
PinMsg = pin_messages,
DelMsg = delete_messages,
Info = change_info
}
end
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
function ChannelJoin(msg)
JoinChannel = true
local chh = Redis:get(Timo.."chfalse")
if chh then
local url = https.request("https://api.telegram.org/bot"..Token.."/getchatmember?chat_id="..chh.."&user_id="..msg.sender.user_id)
data = json:decode(url)
if data.result.status == "left" or data.result.status == "kicked" then
JoinChannel = false 
end
end
return JoinChannel
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender.user_id
local msg_id = msg.id
var(msg.content)
if data.sender.luatele == "messageSenderChat" and Redis:get(Timo.."Lock:channell"..msg_chat_id) then
print(Redis:get(Timo.."chadmin"..msg_chat_id))
print(data.sender.chat_id)
if data.sender.chat_id ~= Redis:get(Timo.."chadmin"..msg_chat_id) then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
Redis:incr(Timo..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end

if data.content.text then
text = data.content.text.text
else 
text = nil
end
if tonumber(msg.sender.user_id) == tonumber(Timo) then
print('This is reply for Bot')
return false
end
if Statusrestricted(msg.chat_id,msg.sender.user_id).BanAll == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).ktmall == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).BanGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).SilentGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if tonumber(msg.sender.user_id) == 5284311721 then
msg.Name_Controller = 'المبرمج تيمو'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 1825532106 then
msg.Name_Controller = 'المبرمج سيزر'
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender.user_id) == true then  
msg.The_Controller = 1
msg.Name_Controller = 'المطور الاساسي '
elseif Redis:sismember(Timo.."Timo:DevelopersQ:Groups",msg.sender.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = 'المطور الثانوي'
elseif Redis:sismember(Timo.."HELPBEVQ:Groups",msg.sender.user_id) == true then
msg.The_Controller = 22
msg.Name_Controller = 'المساعد'
elseif Redis:sismember(Timo.."Timo:Developers:Groups",msg.sender.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(Timo.."Timo:Developer:Bot:Reply"..msg.chat_id) or 'المطور '
elseif Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = Redis:get(Timo.."Timo:PresidentQ:Group:Reply"..msg.chat_id) or 'المالك'
elseif Redis:sismember(Timo.."Timo:TheBasics:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(Timo.."Timo:President:Group:Reply"..msg.chat_id) or 'المنشئ الاساسي'
elseif Redis:sismember(Timo.."Timo:Originators:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(Timo.."Timo:Constructor:Group:Reply"..msg.chat_id) or 'المنشئ '
elseif Redis:sismember(Timo.."Timo:Managers:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(Timo.."Timo:Manager:Group:Reply"..msg.chat_id) or 'المدير '
elseif Redis:sismember(Timo.."Timo:Addictive:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(Timo.."Timo:Admin:Group:Reply"..msg.chat_id) or 'الادمن '
elseif Redis:sismember(Timo.."Timo:Distinguished:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(Timo.."Timo:Vip:Group:Reply"..msg.chat_id) or 'المميز '
elseif tonumber(msg.sender.user_id) == tonumber(Timo) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.Name_Controller = Redis:get(Timo.."Timo:Mempar:Group:Reply"..msg.chat_id) or 'العضو '
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.DevelopersQ = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Developers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.TheBasicsm = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 9 then
msg.TheBasics = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Originators = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Managers = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Addictive = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Distinguished = true
end
if Redis:get(Timo.."Timo:Lock:text"..msg_chat_id) and not msg.Distinguished then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" then
if Redis:get(Timo.."Timo:Status:Welcome"..msg_chat_id) then
local ban = LuaTele.getUser(msg.sender.user_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Welcome = Redis:get(Timo.."Timo:Welcome:Group"..msg_chat_id)
if Welcome then 
if ban.username then
banusername = '@'..ban.username
else
banusername = 'لا يوجد '
end
Welcome = Welcome:gsub('{name}',ban.first_name) 
Welcome = Welcome:gsub('{user}',banusername) 
Welcome = Welcome:gsub('{gbio}',bio.user_name) 
Welcome = Welcome:gsub('{NameCh}',Get_Chat.title) 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md")  
else
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ اطلق دخول ['..ban.first_name..'](tg://user?id='..msg.sender.user_id..')\n ᪣ نورت الجروب {'..Get_Chat.title..'}',"md")  
end
end
end
if not msg.Distinguished and msg.content.luatele ~= "messageChatAddMembers" and Redis:hget(Timo.."Timo:Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender.user_id) == tonumber(Timo) then
return false
end
local floods = Redis:hget(Timo.."Timo:Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_Max = Redis:hget(Timo.."Timo:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(Redis:get(Timo.."Timo:Spam:Cont"..msg.sender.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(Redis:hget(Timo.."Timo:Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = Redis:hget(Timo.."Timo:Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ قام بالتكرار في الجروب وتم طرده").Reply,"md",true)
end
if type == "del" then 
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ قام بالتكرار في الجروب وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ قام بالتكرار في الجروب وتم كتمه").Reply,"md",true)  
end
end
Redis:setex(Timo.."Timo:Spam:Cont"..msg.sender.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if Redis:hget(Timo.."Timo:Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_Max = Redis:hget(Timo.."Timo:Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 
if text and not msg.Distinguished then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if Redis:get(Timo.."Timo:Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Timo.."Timo:Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Timo.."Timo:Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(Timo.."Timo:Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if msg.forward_info and not msg.Developers then -- التوجيه
local Fwd_Group = Redis:get(Timo.."Timo:Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Fwd_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Fwd_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Fwd_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is forward')
return false
end 

if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Distinguished then  -- الكيبورد
local Keyboard_Group = Redis:get(Timo.."Timo:Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then
var(LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}))
elseif Keyboard_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Keyboard_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Keyboard_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
print('This is reply_markup')
end 

if msg.content.location and not msg.Distinguished then  -- الموقع
if location then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
print('This is location')
end 

if msg.content.entities and msg..content.entities[0] and msg.content.entities[0].type.luatele == "textEntityTypeUrl" and not msg.Distinguished then  -- الماركداون
local Markduan_Gtoup = Redis:get(Timo.."Timo:Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Markduan_Gtoup == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Markduan_Gtoup == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Markduan_Gtoup == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is textEntityTypeUrl')
end 

if msg.content.game and not msg.Distinguished then  -- الالعاب
local Games_Group = Redis:get(Timo.."Timo:Lock:geam"..msg_chat_id)
if Games_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Games_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Games_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Games_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is games')
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = Redis:get(Timo.."Timo:lockpin"..msg_chat_id)
if Pin_Msg and not msg.Managers then
if Pin_Msg:match("(%d+)") then 
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لا استطيع تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
end
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لا استطيع الغاء تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ التثبيت معطل من قبل المدراء ","md",true)
end
print('This is message Pin')
end 


if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
print('This is Add Membeers ')
Redis:incr(Timo.."Num:Add:Memp"..msg_chat_id..":"..msg.sender.user_id) 
local AddMembrs = Redis:get(Timo.."Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = Redis:get(Timo.."Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = LuaTele.getUser(v) 
print(v)
if v == tonumber(Timo) then
local N = (Redis:get(Timo.."Name:Bot") or "سيلفا")
photo = LuaTele.getUserProfilePhotos(Timo)
local bot = '* ╗ مـرحـبــا انا بــوت '..N..'\n╣ اخـتصـاصـي  ادارة الجـروبــات\n╣ مـن السـب والشـتيمـه والابــاحـه\n╣ لتفعيل البــوت اتبــاع الخـطـوات\n╣❶ ارفع البــوت مـشـرف في مـجـمـوعه\n╣ وارسـل تفعيل في مـجـمـوعه\n╣❷ لو ارت تفعيل ردود السـورس\n╣ اكتب تفعيل ردود السـورس\n╝ مـطـور الـبــوت 𓄼 @'..UserSudo..' 𓄹\n*'
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اضف البوت لمجموعتك ✅', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(bot).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
end


if msg.content.luatele == "messageContact" and not msg.Distinguished then  -- الجهات
local Contact_Group = Redis:get(Timo.."Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Contact_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Contact_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Contact_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Contact')
end 

if msg.content.luatele == "messageVideoNote" and not msg.Distinguished then  -- بصمه الفيديو
local Videonote_Group = Redis:get(Timo.."Timo:Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Videonote_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Videonote_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Videonote_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is video Note')
end 

if msg.content.luatele == "messageDocument" and not msg.Distinguished then  -- الملفات
local Document_Group = Redis:get(Timo.."Timo:Lock:Document"..msg_chat_id)
if Document_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Document_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Document_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Document_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Document')
end 

if msg.content.luatele == "messageAudio" and not msg.Distinguished then  -- الملفات الصوتيه
local Audio_Group = Redis:get(Timo.."Timo:Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Audio_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Audio_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Audio_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Audio')
end 

if msg.content.luatele == "messageVideo" and not msg.Distinguished then  -- الفيديو
local Video_Grouo = Redis:get(Timo.."Timo:Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Video_Grouo == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Video_Grouo == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Video_Grouo == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Video')
end 

if msg.content.luatele == "messageVoiceNote" and not msg.Distinguished then  -- البصمات
local Voice_Group = Redis:get(Timo.."Timo:Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Voice_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Voice_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Voice_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Voice')
end 

if msg.content.luatele == "messageSticker" and not msg.Distinguished then  -- الملصقات
local Sticker_Group = Redis:get(Timo.."Timo:Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Sticker_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Sticker_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Sticker_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Sticker')
end 

if msg.via_bot_user_id ~= 0 and not msg.Distinguished then  -- انلاين
local Inlen_Group = Redis:get(Timo.."Timo:Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Inlen_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Inlen_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Inlen_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is viabot')
end

if msg.content.luatele == "messageAnimation" and not msg.Distinguished then  -- المتحركات
local Gif_group = Redis:get(Timo.."Timo:Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Gif_group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Gif_group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Gif_group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Animation')
end 

if msg.content.luatele == "messagePhoto" and not msg.Distinguished then  -- الصور
local Photo_Group = Redis:get(Timo.."Timo:Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Photo_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Photo_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Photo_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Photo delete')
end
if msg.content.photo and Redis:get(Timo.."Timo:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id) then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local ChatPhoto = LuaTele.setChatPhoto(msg_chat_id,idPhoto)
if (ChatPhoto.luatele == "error") then
Redis:del(Timo.."Timo:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا استطيع تغيير صوره الجروب لاني لست ادمن او ليست لديه الصلاحيه *","md",true)    
end
Redis:del(Timo.."Timo:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تغيير صوره الجروب الجروب *","md",true)    
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = Redis:get(Timo.."Timo:Lock:Link"..msg_chat_id)  
if not msg.Distinguished then
if link_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif link_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif link_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif link_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is link ')
return false
end
end
if text and text:match("@[%a%d_]+") and not msg.Distinguished then 
local UserName_Group = Redis:get(Timo.."Timo:Lock:User:Name"..msg_chat_id)
if UserName_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif UserName_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif UserName_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif UserName_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is username ')
end
if text and text:match("#[%a%d_]+") and not msg.Distinguished then 
local Hashtak_Group = Redis:get(Timo.."Timo:Lock:hashtak"..msg_chat_id)
if Hashtak_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Hashtak_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Hashtak_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Hashtak_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is hashtak ')
end
if text and text:match("/[%a%d_]+") and not msg.Distinguished then 
local comd_Group = Redis:get(Timo.."Timo:Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif comd_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif comd_Group == "ktm" then
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif comd_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
if (Redis:get(Timo..'Timo:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(Timo.."Timo:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(Timo.."Timo:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(Timo.."Timo:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:set(Timo.."Timo:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(Timo.."Timo:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(Timo.."Timo:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(Timo.."Timo:Filter:Text"..msg.sender.user_id..':'..msg_chat_id, text)  
Redis:sadd(Timo.."Timo:List:Filter"..msg_chat_id,'text:'..text)  
Filters = 'نص'
end
Redis:set(Timo..'Timo:FilterText'..msg_chat_id..':'..msg.sender.user_id,'true1')
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ ارسل تحذير𓄼 "..Filters.." 𓄹عند ارساله*","md",true)  
end
end
if text and (Redis:get(Timo..'Timo:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true1') then
local Text_Filter = Redis:get(Timo.."Timo:Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
if Text_Filter then   
Redis:set(Timo.."Timo:Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
Redis:del(Timo.."Timo:Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
Redis:del(Timo..'Timo:FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ تم اضافه رد التحذير*","md",true)  
end
if text and (Redis:get(Timo..'Timo:FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'DelFilter') then   
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
Redis:srem(Timo.."Timo:List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(Timo.."Timo:Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
Redis:srem(Timo.."Timo:List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:del(Timo.."Timo:Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
Redis:srem(Timo.."Timo:List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(Timo.."Timo:Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
Redis:srem(Timo.."Timo:List:Filter"..msg_chat_id,'text:'..text)  
Redis:del(Timo.."Timo:Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
Redis:del(Timo..'Timo:FilterText'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم الغاء منع𓄼 "..Filters.."𓄹*","md",true)  
end
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(Timo.."Timo:Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Developers then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لقد تم منع هذه𓄼 "..statusfilter.."𓄹هنا*\n ᪣ "..ReplyFilters,"md",true)   
end
end
if text and Redis:get(Timo.."Timo:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(Timo.."Timo:All:Get:Reides:Commands:Group"..text)
if NewCmmd then
Redis:del(Timo.."Timo:All:Get:Reides:Commands:Group"..text)
Redis:del(Timo.."Timo:All:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(Timo.."Timo:All:Command:List:Group",text)
LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم ازالة هاذا ⇦ 𓄼 "..text.."𓄹*","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد امر بهاذا الاسم*","md",true)
end
Redis:del(Timo.."Timo:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(Timo.."Timo:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(Timo.."Timo:All:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(Timo.."Timo:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(Timo.."Timo:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ ارسل الامر الجديد ليتم وضعه مكان القديم*","md",true)  
end
if text and Redis:get(Timo.."Timo:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(Timo.."Timo:All:Command:Reids:Group:New"..msg_chat_id)
Redis:set(Timo.."Timo:All:Get:Reides:Commands:Group"..text,NewCmd)
Redis:sadd(Timo.."Timo:All:Command:List:Group",text)
Redis:del(Timo.."Timo:All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حفظ الامر باسم ⇦𓄼 "..text..' 𓄹*',"md",true)
end

if text and Redis:get(Timo.."Timo:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(Timo.."Timo:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
Redis:del(Timo.."Timo:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
Redis:del(Timo.."Timo:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(Timo.."Timo:Command:List:Group"..msg_chat_id,text)
LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم ازالة هاذا ⇦𓄼 "..text.." 𓄹*","md",true)
else
LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد امر بهاذا الاسم*","md",true)
end
Redis:del(Timo.."Timo:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(Timo.."Timo:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(Timo.."Timo:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(Timo.."Timo:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(Timo.."Timo:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ ارسل الامر الجديد ليتم وضعه مكان القديم*","md",true)  
end
if text and Redis:get(Timo.."Timo:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(Timo.."Timo:Command:Reids:Group:New"..msg_chat_id)
Redis:set(Timo.."Timo:Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
Redis:sadd(Timo.."Timo:Command:List:Group"..msg_chat_id,text)
Redis:del(Timo.."Timo:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حفظ الامر باسم ⇦𓄼 "..text..' 𓄹*',"md",true)
end
if Redis:get(Timo.."Timo:Set:Link"..msg_chat_id..""..msg.sender.user_id) then
if text == "الغاء" then
Redis:del(Timo.."Timo:Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم الغاء حفظ الرابط*","md",true)         
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local LinkGroup = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
Redis:set(Timo.."Timo:Group:Link"..msg_chat_id,LinkGroup)
Redis:del(Timo.."Timo:Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حفظ الرابط بنجاح*","md",true)         
end
end 
if Redis:get(Timo.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Timo.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم الغاء حفظ الترحيب*","md",true)   
end 
Redis:del(Timo.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
Redis:set(Timo.."Timo:Welcome:Group"..msg_chat_id,text) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حفظ ترحيب الجروب*","md",true)     
end
if Redis:get(Timo.."Timo:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Timo.."Timo:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم الغاء حفظ القوانين*","md",true)   
end 
Redis:set(Timo.."Timo:Group:Rules" .. msg_chat_id,text) 
Redis:del(Timo.."Timo:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حفظ قوانين الجروب*","md",true)  
end  
if Redis:get(Timo.."Timo:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(Timo.."Timo:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم الغاء حفظ وصف الجروب*","md",true)   
end 
LuaTele.setChatDescription(msg_chat_id,text) 
Redis:del(Timo.."Timo:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حفظ وصف الجروب*","md",true)  
end  
if text  then
local test = Redis:get(Timo.."Timo:Text:Manager"..msg.sender.user_id..":"..msg_chat_id.."")
if Redis:get(Timo.."Timo:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Timo.."Timo:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.sticker then   
Redis:set(Timo.."Timo:Add:Rd:Manager:Stekrs"..test..msg_chat_id, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then  
Redis:set(Timo.."Timo:Add:Rd:Manager:Vico"..test..msg_chat_id, msg.content.voice_note.voice.remote.id)  
end   
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Timo.."Timo:Add:Rd:Manager:Text"..test..msg_chat_id, text)  
end  
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حفظ في قائمه الردود *\n* ᪣ ارسل𓄼"..test.."𓄹لرئية الرد*","md",true)  
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Timo.."Timo:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(Timo.."Timo:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true1")
Redis:set(Timo.."Timo:Text:Manager"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:del(Timo.."Timo:Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(Timo.."Timo:Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:sadd(Timo.."Timo:List:Manager"..msg_chat_id.."", text)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𓄼• تغيير الرد •𓄹', data = msg.sender.user_id..'/chengreplyg'},
},
{
{text = '𓄼• الغاء الامر •𓄹', data = msg.sender.user_id..'/delamrredis'},
},
{
{text = '𓄼• ѕᴏ𝗎ʀᴄᴇ ѕᴇʟᴠᴀ •𓄹', url='https://t.me/SU_SELVA'},
},
}
}
LuaTele.sendText(msg_chat_id,msg_id,[[*
▱▰▱▰▱▰▱▰▱▰▱▰▱▰
᪣ ارسل الان الكلمه لاضافتها في الردود
لتغير الرد اضغظ علي زر تغيير الرد
للخروج من الامر اضغظ علي زر الغاء الامر
▱▰▱▰▱▰▱▰▱▰▱▰▱▰
*]],"md",true, false, false, false, reply_markup)
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Timo.."Timo:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
Redis:del(Timo.."Timo:Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(Timo.."Timo:Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(Timo.."Timo:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(Timo.."Timo:List:Manager"..msg_chat_id.."", text)
LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حذف الرد في قائمه الردود *","md",true)  
return false
end
end
if text and Redis:get(Timo.."Timo:Status:ReplySudo"..msg_chat_id) then
local anemi = Redis:get(Timo.."Timo:Add:Rd:Sudo:Gif"..text)   
local veico = Redis:get(Timo.."Timo:Add:Rd:Sudo:vico"..text)   
local stekr = Redis:get(Timo.."Timo:Add:Rd:Sudo:stekr"..text)     
local Text = Redis:get(Timo.."Timo:Add:Rd:Sudo:Text"..text)   
local photo = Redis:get(Timo.."Timo:Add:Rd:Sudo:Photo"..text)
local video = Redis:get(Timo.."Timo:Add:Rd:Sudo:Video"..text)
local document = Redis:get(Timo.."Timo:Add:Rd:Sudo:File"..text)
local audio = Redis:get(Timo.."Timo:Add:Rd:Sudo:Audio"..text)
local video_note = Redis:get(Timo.."Timo:Add:Rd:Sudo:video_note"..text)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Timo..'Timo:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Timo..'Timo:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,Text,"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,'')
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, '', "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, '', "md") 
end
end
if text and Redis:get(Timo.."Timo:Status:Reply"..msg_chat_id) then
local anemi = Redis:get(Timo.."Timo:Add:Rd:Manager:Gif"..text..msg_chat_id)   
local veico = Redis:get(Timo.."Timo:Add:Rd:Manager:Vico"..text..msg_chat_id)   
local stekr = Redis:get(Timo.."Timo:Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
local Texingt = Redis:get(Timo.."Timo:Add:Rd:Manager:Text"..text..msg_chat_id)   
local photo = Redis:get(Timo.."Timo:Add:Rd:Manager:Photo"..text..msg_chat_id)
local video = Redis:get(Timo.."Timo:Add:Rd:Manager:Video"..text..msg_chat_id)
local document = Redis:get(Timo.."Timo:Add:Rd:Manager:File"..text..msg_chat_id)
local audio = Redis:get(Timo.."Timo:Add:Rd:Manager:Audio"..text..msg_chat_id)
local video_note = Redis:get(Timo.."Timo:Add:Rd:Manager:video_note"..text..msg_chat_id)
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(Timo..'Timo:Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(Timo..'Timo:Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
LuaTele.sendText(msg_chat_id,msg_id,Texingt,"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,'')
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, '', "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, '', "md") 
end
end
if text then
local test = Redis:get(Timo.."Timo:Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(Timo.."Timo:Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(Timo.."Timo:Set:Rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.sticker then   
Redis:set(Timo.."Timo:Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
end   
if msg.content.voice_note then  
Redis:set(Timo.."Timo:Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
end   
if msg.content.animation then   
Redis:set(Timo.."Timo:Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Timo.."Timo:Add:Rd:Sudo:Text"..test, text)  
end  
LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حفظ الرد العام *\n* ᪣ ارسل𓄼"..test.."𓄹لرئية الرد*","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(Timo.."Timo:Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(Timo.."Timo:Set:Rd"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(Timo.."Timo:Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(Timo.."Timo:List:Rd:Sudo", text)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𓄼• تغيير الرد •𓄹', data = msg.sender.user_id..'/chengreplys'},
},
{
{text = '𓄼• الغاء الامر •𓄹', data = msg.sender.user_id..'/delamrredis'},
},
{
{text = '𓄼• ѕᴏ𝗎ʀᴄᴇ ѕᴇʟᴠᴀ •𓄹', url='https://t.me/SU_SELVA'},
},
}
}
LuaTele.sendText(msg_chat_id,msg_id,[[*
▱▰▱▰▱▰▱▰▱▰▱▰▱▰
᪣ ارسل الان الكلمه لاضافتها في الردود
لتغير الرد اضغظ علي زر تغيير الرد
للخروج من الامر اضغظ علي زر الغاء الامر
▱▰▱▰▱▰▱▰▱▰▱▰▱▰
*]],"md",true, false, false, false, reply_markup)
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(Timo.."Timo:Set:On"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
Redis:del(Timo..'Timo:'..v..text)
end
Redis:del(Timo.."Timo:Set:On"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(Timo.."Timo:List:Rd:Sudo", text)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حذف الرد في الردود العامه *","md",true)  
end
end
if Redis:get(Timo.."Timo:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '𓄼 الغاء الامر 𓄹' then   
Redis:del(Timo.."Timo:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n☆︙تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(Timo.."Timo:ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
Redis:set(Timo.."Timo:PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
Redis:set(Timo.."Timo:PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
Redis:set(Timo.."Timo:PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
Redis:set(Timo.."Timo:PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
Redis:set(Timo.."Timo:PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
Redis:set(Timo.."Timo:PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
Redis:set(Timo.."Timo:PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
Redis:set(Timo.."Timo:PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
Redis:set(Timo.."Timo:PinMsegees:"..v,text)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"☆︙تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ","md",true)      
Redis:del(Timo.."Timo:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(Timo.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '𓄼 الغاء الامر 𓄹' then   
Redis:del(Timo.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n*᪣ تم الغاء الاذاعه بالتوجيه للخاص*","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(Timo.."Timo:Num:User:Pv") 
LuaTele.sendText(msg_chat_id,msg_id,"*᪣ تم التوجيه الى 𓄼"..#list.."𓄹 مشترك ف البوت *","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(Timo.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if Redis:get(Timo.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '𓄼 الغاء الامر 𓄹' then   
Redis:del(Timo.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n*᪣ تم الغاء الاذاعه للخاص*","md",true)  
end 
local list = Redis:smembers(Timo.."Timo:Num:User:Pv") 
if msg.content.voice_chats then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.voice_chats.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"*᪣ تمت الاذاعه الى 𓄼"..#list.."𓄹 عضو في البوت *","md",true)      
Redis:del(Timo.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(Timo.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '𓄼 الغاء الامر 𓄹' then   
Redis:del(Timo.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n*᪣ تم الغاء الاذاعه للمجموعات*","md",true)  
end 
local list = Redis:smembers(Timo.."Timo:ChekBotAdd") 
if msg.content.voice_chats then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.voice_chats.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then
for k,v in pairs(list) do 
LuaTele.sendText(v,0,text,"md",true)
end
end
LuaTele.sendText(msg_chat_id,msg_id,"*᪣ تمت الاذاعه الى 𓄼"..#list.."𓄹 جروب في البوت* ","md",true)      
Redis:del(Timo.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
------------------------------------------------------------------------------------------------------------
if Redis:get(Timo.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == '𓄼 الغاء الامر 𓄹' then   
Redis:del(Timo.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n*᪣ تم الغاء الاذاعه بالتوجيه للمجموعات*","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(Timo.."Timo:ChekBotAdd")   
LuaTele.sendText(msg_chat_id,msg_id,"*᪣  تم التوجيه الى 𓄼"..#list.."𓄹 جروب في البوت*","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(Timo.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if text and Redis:get(Timo..'Timo:GetTexting:DevTimo'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == '𓄼 الغاء الامر 𓄹' then 
Redis:del(Timo..'Timo:GetTexting:DevTimo'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم الغاء حفظ كليشة المطور')
end
Redis:set(Timo..'Timo:Texting:DevTimo',text)
Redis:del(Timo..'Timo:GetTexting:DevTimo'..msg_chat_id..':'..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم حفظ كليشة المطور')
end
if Redis:get(Timo.."Timo:Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n ᪣ تم الغاء امر تعين الايدي عام","md",true)  
Redis:del(Timo.."Timo:Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(Timo.."Timo:Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(Timo.."Timo:Set:Id:Groups",text:match("(.*)"))
LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم تعين الايدي عام',"md",true)  
end
if Redis:get(Timo.."Timo:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
LuaTele.sendText(msg_chat_id,msg_id, "\n ᪣ تم الغاء امر تعين الايدي","md",true)  
Redis:del(Timo.."Timo:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(Timo.."Timo:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(Timo.."Timo:Set:Id:Group"..msg.chat_id,text:match("(.*)"))
LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم تعين الايدي الجديد',"md",true)  
end
if Redis:get(Timo.."Timo:Change:Timo:Name:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == '𓄼 الغاء الامر 𓄹' then   
Redis:del(Timo.."Timo:Change:Timo:Name:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n ᪣ تم الغاء امر تغير اسم البوت","md",true)  
end 
Redis:del(Timo.."Timo:Change:Timo:Name:Bot"..msg.sender.user_id) 
Redis:set(Timo.."Timo:Name:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, " ᪣ تم تغير اسم البوت الى - "..text,"md",true)    
end 
if Redis:get(Timo.."Timo:Change:Start:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == '𓄼 الغاء الامر 𓄹' then   
Redis:del(Timo.."Timo:Change:Start:Bot"..msg.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id, "\n ᪣ تم الغاء امر تغير كليشه start","md",true)  
end 
Redis:del(Timo.."Timo:Change:Start:Bot"..msg.sender.user_id) 
Redis:set(Timo.."Timo:Start:Bot",text) 
return LuaTele.sendText(msg_chat_id,msg_id, " ᪣ تم تغيير كليشه start - "..text,"md",true)    
end 
if Redis:get(Timo.."Timo:Game:Smile"..msg.chat_id) then
if text == Redis:get(Timo.."Timo:Game:Smile"..msg.chat_id) then
Redis:incrby(Timo.."Timo:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Timo.."Timo:Game:Smile"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد فزت في اللعبه \n ᪣ اللعب مره اخره وارسل - سمايل او سمايلات","md",true)  
else
Redis:del(Timo.."Timo:Game:Smile"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد خسرت حضا اوفر في المره القادمه\n ᪣ اللعب مره اخره وارسل - سمايل او سمايلات","md",true)  
end
end 
if Redis:get(Timo.."Timo:Game:Monotonous"..msg.chat_id) then
if text == Redis:get(Timo.."Timo:Game:Monotonous"..msg.chat_id) then
Redis:del(Timo.."Timo:Game:Monotonous"..msg.chat_id)
Redis:incrby(Timo.."Timo:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد فزت في اللعبه \n ᪣ اللعب مره اخره وارسل - الاسرع او ترتيب","md",true)  
else
Redis:del(Timo.."Timo:Game:Monotonous"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد خسرت حضا اوفر في المره القادمه\n ᪣ اللعب مره اخره وارسل - الاسرع او ترتيب","md",true)  
end
end 
if Redis:get(Timo.."Timo:Game:Riddles"..msg.chat_id) then
if text == Redis:get(Timo.."Timo:Game:Riddles"..msg.chat_id) then
Redis:incrby(Timo.."Timo:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Timo.."Timo:Game:Riddles"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد فزت في اللعبه \n ᪣ اللعب مره اخره وارسل - حزوره","md",true)  
else
Redis:del(Timo.."Timo:Game:Riddles"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد خسرت حضا اوفر في المره القادمه\n ᪣ اللعب مره اخره وارسل - حزوره","md",true)  
end
end
if Redis:get(Timo.."Timo:Game:Meaningof"..msg.chat_id) then
if text == Redis:get(Timo.."Timo:Game:Meaningof"..msg.chat_id) then
Redis:incrby(Timo.."Timo:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Timo.."Timo:Game:Meaningof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد فزت في اللعبه \n ᪣ اللعب مره اخره وارسل - معاني","md",true)  
else
Redis:del(Timo.."Timo:Game:Meaningof"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد خسرت حضا اوفر في المره القادمه\n ᪣ اللعب مره اخره وارسل - معاني","md",true)  
end
end
if Redis:get(Timo.."Timo:Game:Reflection"..msg.chat_id) then
if text == Redis:get(Timo.."Timo:Game:Reflection"..msg.chat_id) then
Redis:incrby(Timo.."Timo:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(Timo.."Timo:Game:Reflection"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد فزت في اللعبه \n ᪣ اللعب مره اخره وارسل - العكس","md",true)  
else
Redis:del(Timo.."Timo:Game:Reflection"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد خسرت حضا اوفر في المره القادمه\n ᪣ اللعب مره اخره وارسل - العكس","md",true)  
end
end
if Redis:get(Timo.."Timo:Game:Estimate"..msg.chat_id..msg.sender.user_id) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ عذرا لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n","md",true)  
end 
local GETNUM = Redis:get(Timo.."Timo:Game:Estimate"..msg.chat_id..msg.sender.user_id)
if tonumber(NUM) == tonumber(GETNUM) then
Redis:del(Timo.."Timo:SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(Timo.."Timo:Game:Estimate"..msg.chat_id..msg.sender.user_id)
Redis:incrby(Timo.."Timo:Num:Add:Games"..msg.chat_id..msg.sender.user_id,5)  
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸︙تم اضافة { 5 } من النقاط \n","md",true)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
Redis:incrby(Timo.."Timo:SADD:NUM"..msg.chat_id..msg.sender.user_id,1)
if tonumber(Redis:get(Timo.."Timo:SADD:NUM"..msg.chat_id..msg.sender.user_id)) >= 3 then
Redis:del(Timo.."Timo:SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(Timo.."Timo:Game:Estimate"..msg.chat_id..msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ اوبس لقد خسرت في اللعبه \n ᪣ حظآ اوفر في المره القادمه \n ᪣ كان الرقم الذي تم تخمينه { "..GETNUM.." }","md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ اوبس تخمينك غلط \n ᪣ ارسل رقم تخمنه مره اخرى ","md",true)  
end
end
end
end
if Redis:get(Timo.."Timo:Game:Difference"..msg.chat_id) then
if text == Redis:get(Timo.."Timo:Game:Difference"..msg.chat_id) then 
Redis:del(Timo.."Timo:Game:Difference"..msg.chat_id)
Redis:incrby(Timo.."Timo:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد فزت في اللعبه \n ᪣ اللعب مره اخره وارسل - المختلف","md",true)  
else
Redis:del(Timo.."Timo:Game:Difference"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد خسرت حضا اوفر في المره القادمه\n ᪣ اللعب مره اخره وارسل - المختلف","md",true)  
end
end
if Redis:get(Timo.."Timo:Game:Example"..msg.chat_id) then
if text == Redis:get(Timo.."Timo:Game:Example"..msg.chat_id) then 
Redis:del(Timo.."Timo:Game:Example"..msg.chat_id)
Redis:incrby(Timo.."Timo:Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد فزت في اللعبه \n ᪣ اللعب مره اخره وارسل - امثله","md",true)  
else
Redis:del(Timo.."Timo:Game:Example"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ لقد خسرت حضا اوفر في المره القادمه\n ᪣ اللعب مره اخره وارسل - امثله","md",true)  
end
end
if text then
local NewCmmd = Redis:get(Timo.."Timo:All:Get:Reides:Commands:Group"..text) or Redis:get(Timo.."Timo:Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if text == 'رفع النسخه' and msg.reply_to_message_id ~= 0 or text == 'رفع النسخه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(Timo) ~= tonumber(FilesJson.BotId) then
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
LuaTele.sendText(msg_chat_id,msg_id,' ᪣ جاري استرجاع المشتركين والجروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(Timo..'Timo:Num:User:Pv',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
Redis:sadd(Timo.."Timo:ChekBotAdd",GroupId) 
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
Redis:sadd(Timo.."Timo:TheBasics:Group"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
Redis:sadd(Timo.."Timo:Originators:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
Redis:sadd(Timo.."Timo:Managers:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
Redis:sadd(Timo.."Timo:Addictive:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
Redis:sadd(Timo.."Timo:Distinguished:Group"..GroupId,v)
end
end 
end
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم استرجاع {'..X..'} مجموعه \n ᪣ واسترجاع {'..Y..'} مشترك في البوت')
end
end
if text == 'رفع نسخه تشاكي' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(Timo) then 
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
Redis:sadd(Timo.."Timo:ChekBotAdd",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
Redis:sadd(Timo.."Timo:Originators:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
Redis:sadd(Timo.."Timo:Managers:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
Redis:sadd(Timo.."Timo:Addictive:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
Redis:sadd(Timo.."Timo:TheBasics:Group"..idg,idASAS)
end;end
end
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم استرجاع المجموعات من نسخه تشاكي')
else
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ الملف لا يدعم هاذا البوت')
end
end
end
if text == 'تحديث السورس' or text == '𓄼 تحديث السورس 𓄹' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
--os.execute('rm -rf Timo.lua')
--download('https://raw.githubusercontent.com/EIGEBT/TIMO-SELVA/master/Timo.lua','Timo.lua')
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ تم تحديث السورس * ',"md",true)  
end
if text == '𓄼 تعطيل الاذاعه 𓄹' or text == 'تعطيل الاذاعه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:SendBcBot") 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل الاذاعه ","md",true)
end
if text == '𓄼 تفعيل الاذاعه 𓄹' or text == 'تفعيل الاذاعه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:SendBcBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تفعيل الاذاعه للمطورين ","md",true)
end
if text == '𓄼 تعطيل المغادره 𓄹' or text == 'تعطيل المغادره' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:LeftBot") 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل المغادره ","md",true)
end
if text == '𓄼 تفعيل المغادره 𓄹' or text == 'تفعيل المغادره' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:LeftBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تفعيل المغادره للمطورين ","md",true)
end
if (Redis:get(Timo.."Timo:AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == '𓄼 الغاء الامر 𓄹' then   
Redis:del(Timo.."Timo:AddSudosNew"..msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, "\n ᪣ تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
Redis:del(Timo.."Timo:AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ تم تغيير المطور الاساسي اصبح على : [@"..text:gsub('@','').."]","md",true)  
end
end
if text == 'تغيير المطور الاساسي' or text == '𓄼 تغيير المطور الاساسي 𓄹' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
Redis:set(Timo.."Timo:AddSudosNew"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ ارسل معرف المطور الاساسي مع @","md",true)
end
if text == '𓄼 جلب النسخه 𓄹' or text == 'جلب النسخه' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Groups = Redis:smembers(Timo..'Timo:ChekBotAdd')  
local UsersBot = Redis:smembers(Timo..'Timo:Num:User:Pv')  
local Get_Json = '{"BotId": '..Timo..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President = Redis:smembers(Timo.."Timo:TheBasics:Group"..v)
local Constructor = Redis:smembers(Timo.."Timo:Originators:Group"..v)
local Manager = Redis:smembers(Timo.."Timo:Managers:Group"..v)
local Admin = Redis:smembers(Timo.."Timo:Addictive:Group"..v)
local Vips = Redis:smembers(Timo.."Timo:Distinguished:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"tt_t_4"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '* ᪣ تم جلب النسخه\n ᪣ احصائيات𓄼 '..#Groups..' 𓄹المجموعات \n ᪣ احصائيات𓄼 '..#UsersBot..' 𓄹المشتركين *\n', 'md')
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo..'Timo:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
LuaTele.sendText(msg_chat_id,msg_id,'* ᪣ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text == 'الاحصائيات' or text == '𓄼 الاحصائيات 𓄹' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_name = user_info.first_name
local photo = LuaTele.getUserProfilePhotos(Timo)
local UserInfo = LuaTele.getUser(Timo)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end 
NamesBot = (Redis:get(Timo.."Timo:Name:Bot") or "سيلفا")
Groups = (Redis:scard(Timo..'Timo:ChekBotAdd') or 0)
Users = (Redis:scard(Timo..'Timo:Num:User:Pv') or 0)
if photo.total_count > 0 then
local selva = 'اسم بوت = 𓄼 '..NamesBot..' 𓄹'
local Grosupsw = 'الجروبات = 𓄼 '..Groups..' 𓄹'
local Usperos = 'المشتركين = 𓄼 '..Users..' 𓄹'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text =first_name, url = "https://t.me/SU_SELVA"}
},
{
{text = selva, url = 't.me/SU_SELVA'}, 
},
{
{text = Grosupsw, url = 't.me/SU_SELVA'}, 
},
{
{text = Usperos, url = 't.me/SU_SELVA'}, 
},
{
{text = 'اضف البوت لمجموعتك ✅', url = 't.me/'..UserBot..'?startgroup=new'},
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(NamesBots).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
elseif text == 'الجروبات' or text == '𓄼 الجروبات 𓄹' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_name = user_info.first_name
local photo = LuaTele.getUserProfilePhotos(Timo)
local UserInfo = LuaTele.getUser(Timo)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end 
NamesBot = (Redis:get(Timo.."Timo:Name:Bot") or "سيلفا")
Groups = (Redis:scard(Timo..'Timo:ChekBotAdd') or 0)
Users = (Redis:scard(Timo..'Timo:Num:User:Pv') or 0)
if photo.total_count > 0 then
local selva = 'اسم بوت = 𓄼 '..NamesBot..' 𓄹'
local Grosupsw = 'الجروبات = 𓄼 '..Groups..' 𓄹'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text =first_name, url = "https://t.me/SU_SELVA"}
},
{
{text = selva, url = 't.me/SU_SELVA'}, 
},
{
{text = Grosupsw, url = 't.me/SU_SELVA'}, 
},
{
{text = 'اضف البوت لمجموعتك ✅', url = 't.me/'..UserBot..'?startgroup=new'},
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(NamesBots).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
elseif text == 'المشتركين' or text == '𓄼 المشتركين 𓄹' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_name = user_info.first_name
local photo = LuaTele.getUserProfilePhotos(Timo)
local UserInfo = LuaTele.getUser(Timo)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end 
NamesBot = (Redis:get(Timo.."Timo:Name:Bot") or "سيلفا")
Groups = (Redis:scard(Timo..'Timo:ChekBotAdd') or 0)
Users = (Redis:scard(Timo..'Timo:Num:User:Pv') or 0)
if photo.total_count > 0 then
local selva = 'اسم بوت = 𓄼 '..NamesBot..' 𓄹'
local Usperos = 'المشتركين = 𓄼 '..Users..' 𓄹'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text =first_name, url = "https://t.me/SU_SELVA"}
},
{
{text = selva, url = 't.me/SU_SELVA'}, 
},
{
{text = Usperos, url = 't.me/SU_SELVA'}, 
},
{
{text = 'اضف البوت لمجموعتك ✅', url = 't.me/'..UserBot..'?startgroup=new'},
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(NamesBots).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == 'تفعيل' and msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(Timo.."Timo:ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(Timo..'Timo:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ عدد الاعضاء قليل لا يمكن تفعيل الجروب  يجب ان يكوم اكثر من :'..Redis:get(Timo..'Timo:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ اسم الجروب =𓄼*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*𓄹\n ᪣ تم التفعيل من قبل *',"md",true)  
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𓄼• ترقيه المالك والادمنيه •𓄹', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = '𓄼• قفل جميع الاوامر •𓄹', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
{
{text = '𓄼• اوامر الحمايه الجروب •𓄹', data =msg.sender.user_id..'/listallAddorr@'..msg_chat_id},
},
}
}
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
{
{text = '𓄼• مغادرة الجروب •𓄹', data = '/Zxchq'..msg_chat_id}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n ᪣ تم تفعيل مجموعه جديده \n ᪣ المستخدم =𓄼*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*𓄹\n ᪣ معلومات الجروب = \n ᪣ عدد الاعضاء = '..Info_Chats.member_count..'\n ᪣ عدد الادمنيه = '..Info_Chats.administrator_count..'\n ᪣ عدد المطرودين = '..Info_Chats.banned_count..'\n ᪣ عدد المقيدين = '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:sadd(Timo.."Timo:ChekBotAdd",msg_chat_id)
Redis:set(Timo.."Timo:Status:Id"..msg_chat_id,true) ;Redis:set(Timo.."Timo:Status:Reply"..msg_chat_id,true) ;Redis:set(Timo.."Timo:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(Timo.."Timo:Status:BanId"..msg_chat_id,true) ;Redis:set(Timo.."Timo:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ اسم الجروب =𓄼*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*𓄹\n ᪣ تم تفعيل الجروب *','md', true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and not msg.Developers then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا انته لست ادمن او مالك الجروب *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(Timo.."Timo:ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(Timo..'Timo:Num:Add:Bot') or 0)) and not msg.ControllerBot then
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ عدد الاعضاء قليل لا يمكن تفعيل الجروب  يجب ان يكوم اكثر من :'..Redis:get(Timo..'Timo:Num:Add:Bot'),"md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ اسم الجروب =𓄼*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*𓄹\n ᪣ تم التفعيل من قبل *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
{
{text = '𓄼• مغادرة الجروب •𓄹', data = '/Zxchq'..msg_chat_id}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n* ᪣ تم تفعيل مجموعه جديده *\n*᪣ المستخدم =𓄼*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*𓄹\n* ᪣ معلومات الجروب = *\n* ᪣ عدد الاعضاء = *'..Info_Chats.member_count..'\n* ᪣ عدد الادمنيه = *'..Info_Chats.administrator_count..'\n* ᪣ عدد المطرودين = *'..Info_Chats.banned_count..'\n* ᪣ عدد المقيدين = *'..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𓄼• ترقيه المالك والادمنيه •𓄹', data = msg.sender.user_id..'/addAdmins@'..msg_chat_id},
},
{
{text = '𓄼• قفل جميع الاوامر •𓄹', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
{
{text = '𓄼• اوامر الحمايه الجروب •𓄹', data =msg.sender.user_id..'/listallAddorr@'..msg_chat_id},
},
}
}
Redis:sadd(Timo.."Timo:ChekBotAdd",msg_chat_id)
Redis:set(Timo.."Timo:Status:Id"..msg_chat_id,true) ;Redis:set(Timo.."Timo:Status:Reply"..msg_chat_id,true) ;Redis:set(Timo.."Timo:Status:ReplySudo"..msg_chat_id,true) ;Redis:set(Timo.."Timo:Status:BanId"..msg_chat_id,true) ;Redis:set(Timo.."Timo:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ اسم الجروب =𓄼*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*𓄹\n ᪣ تم تفعيل الجروب *','md', true, false, false, false, reply_markup)
end
end
if text == 'تعطيل' and msg.Developers then
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(Timo.."Timo:ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ اسم الجروب =𓄼*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*𓄹\n ᪣ تم التعطيل من قبل *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
{
{text = '𓄼• مغادرة الجروب •𓄹', data = '/Zxchq'..msg_chat_id}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n ᪣ تم تعطيل مجموعه جديده \n ᪣ المستخدم =𓄼*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*𓄹\n ᪣ معلومات الجروب = \n ᪣ عدد الاعضاء = '..Info_Chats.member_count..'\n ᪣ عدد الادمنيه = '..Info_Chats.administrator_count..'\n ᪣ عدد المطرودين = '..Info_Chats.banned_count..'\n ᪣ عدد المقيدين = '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(Timo.."Timo:ChekBotAdd",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ اسم الجروب =𓄼*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*𓄹\n ᪣ تم التعطيل من قبل *','md',true)
end
end
if text == 'تعطيل' and not msg.Developers then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا انته لست ادمن او مالك الجروب *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(Timo.."Timo:ChekBotAdd",msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ اسم الجروب =𓄼*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*𓄹\n ᪣ تم التعطيل من قبل *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
break
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
{
{text = '𓄼• مغادرة الجروب •𓄹', data = '/Zxchq'..msg_chat_id}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n ᪣ تم تعطيل مجموعه جديده \n ᪣ المستخدم =𓄼 *['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*𓄹\n ᪣ معلومات الجروب = \n ᪣ عدد الاعضاء = '..Info_Chats.member_count..'\n ᪣ عدد الادمنيه = '..Info_Chats.administrator_count..'\n ᪣ عدد المطرودين = '..Info_Chats.banned_count..'\n ᪣ عدد المقيدين = '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(Timo.."Timo:ChekBotAdd",msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ اسم الجروب =𓄼*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*𓄹\n ᪣ تم التعطيل من قبل *','md',true)
end
end
if chat_type(msg.chat_id) == "GroupBot" and Redis:sismember(Timo.."Timo:ChekBotAdd",msg_chat_id) then
if text == "ايدي" or text == "الايدي" or text == "Id" or text == "ID" and msg.reply_to_message_id == 0 then
if not Redis:get(Timo.."Timo:Status:Id"..msg_chat_id) then
return false
end
local selva = LuaTele.getUser(msg.sender.user_id)
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(Timo..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalPhoto = photo.total_count or 0
local TotalEdit = Redis:get(Timo..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = Redis:get(Timo.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local NumAdd = Redis:get(Timo.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0
local Texting = {'〈 جمالك ده طبيعي يولا 🙈💗 〉',"〈 غير بقاا صورتك يا قمر 😻🤍 〉 ","〈 يخرشي علي العسل ده 🥺💔 〉","〈 صورتك ولا صورت القمر 🌙💕 〉","〈 صورتك عثل ينوحيي 🙈🌝 〉",}
local Description = Texting[math.random(#Texting)]
if selva.username then
selvausername = '@'..selva.username..''
else
selvausername = 'لا يوجد'
end
if selva.first_name then
news = " "..selva.first_name.." "
else
news = " لا يوجد"
end
Get_Is_Id = Redis:get(Timo.."Timo:Set:Id:Groups") or Redis:get(Timo.."Set:Id:Group"..msg_chat_id)
if Redis:get(Timo.."Timo:Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',selvausername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Get_Is_Id)
else
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
end
else
if photo.total_count > 0 then
local selva_ns ='\n* '..Description..'\n💎╔•ᴜѕᴇ = '..selvausername..'\n🐣╠•ѕᴛᴀ =  '..RinkBot..'\n☀️╠•ɪᴅ = '..UserId..'\n💬╠•ᴍѕɢ =  '..TotalMsg..'\n👁╠•ᴛᴘᴅʏʟᴀᴛᴋ =  '..TotalEdit..'\n👥╠•ᴛғᴀᴘʟᴋ =  '..TotalMsgT..'\n👮‍♂️╚•ʙɪᴏ = '..getbio(UserId)..'*'
data = {} 
data.inline_keyboard = {
{
{text =news,url = "https://t.me/"..selva.username..""}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(selva_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
else
local selva_ns ='\n💎╔•ᴜѕᴇ = '..selvausername..'\n🐣╠•ѕᴛᴀ =  '..RinkBot..'\n☀️╠•ɪᴅ = '..UserId..'\n💬╠•ᴍѕɢ =  '..TotalMsg..'\n👁╠•ᴛᴘᴅʏʟᴀᴛᴋ =  '..TotalEdit..'\n👥╠•ᴛғᴀᴘʟᴋ =  '..TotalMsgT..'\n👮‍♂️╚•ʙɪᴏ = '..getbio(UserId)..'*'
data = {} 
data.inline_keyboard = {
{
{text =news,url = "https://t.me/"..selva.username..""}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id=" .. msg_chat_id .. "&text=".. URL.escape(selva_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',selvausername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description)
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
return LuaTele.sendText(msg_chat_id,msg_id,'['..Get_Is_Id..']',"md",true) 
else
local selva_ns ='\n💎╔•ᴜѕᴇ = '..selvausername..'\n🐣╠•ѕᴛᴀ =  '..RinkBot..'\n☀️╠•ɪᴅ = '..UserId..'\n💬╠•ᴍѕɢ =  '..TotalMsg..'\n👁╠•ᴛᴘᴅʏʟᴀᴛᴋ =  '..TotalEdit..'\n👥╠•ᴛғᴀᴘʟᴋ =  '..TotalMsgT..'\n👮‍♂️╚•ʙɪᴏ = '..getbio(UserId)..'*'
data = {} 
data.inline_keyboard = {
{
{text =news,url = "https://t.me/"..selva.username..""}, 
},
}
msgg = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendMessage?chat_id=" .. msg_chat_id .. "&text=".. URL.escape(selva_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
end
if text == 'ايدي' or text == 'كشف'  and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local Name = UserInfo.first_name
local UserId = Message_Reply.sender.user_id
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{{text = Name , url = 'tg://user?id='..UserId }},
}
}
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(Timo..'Timo:Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(Timo..'Timo:Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(Timo.."Timo:Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(Timo.."Timo:Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#username',(selva.username or 'لا يوجد')) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*💎╔•ᴜѕᴇ = '..UserInfousername..
'\n🐣╠•ɪᴅ = '..UserId..
'\n☀️╠•ѕᴛᴀ = '..RinkBot..
'\n💬╠•ᴍѕɢ = '..TotalMsg..
'\n👁╠•ᴛᴘᴅʏʟᴀᴛᴋ = '..TotalEdit..
'\n👥╠•ᴛғᴀᴘʟᴋ = '..TotalMsgT..
'\n👮‍♂️╚•ʙɪᴏ = '..getbio(UserId)..
'*',"md",false, false, false, false, reply_markup) 
end
end
if text and text:match('^ايدي @(%S+)$') or text and text:match('^كشف @(%S+)$') then
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا يوجد حساب بهاذا المعرف *","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب *","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع استخدام معرف البوت *","md",true)  
end
local UserId = UserId_Info.id
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = Redis:get(Timo..'Timo:Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(Timo..'Timo:Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(Timo.."Timo:Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(Timo.."Timo:Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username','@'..UserName) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
return LuaTele.sendText(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,
'\n*💎╔•ᴜѕᴇ = '..UserInfousername..
'\n🐣╠•ɪᴅ = '..UserId..
'\n☀️╠•ѕᴛᴀ = '..RinkBot..
'\n💬╠•ᴍѕɢ = '..TotalMsg..
'\n👁╠•ᴛᴘᴅʏʟᴀᴛᴋ = '..TotalEdit..
'\n👥╠•ᴛғᴀᴘʟᴋ = '..TotalMsgT..
'\n👮‍♂️╚•ʙɪᴏ = '..getbio(UserId)..
'*',"md",true) 
end
end
if text == 'رتبتي' then
local ban = LuaTele.getUser(msg.sender.user_id)
local news = '🖤🌝 رتبتك في البوت = '..msg.Name_Controller
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =news,url = "https://t.me/"..ban.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, news, 'md', false, false, false, false, reply_markup)
end
if text == 'انا مين' then
local ban = LuaTele.getUser(msg.sender.user_id)
local news = '🖤🌝 انت ياقلبي = '..msg.Name_Controller
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =news,url = "https://t.me/"..ban.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, news, 'md', false, false, false, false, reply_markup)
end
if text == 'التاريخ' then
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_n = os.date("%Y/%m/%d")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =user_info.first_name,url = "https://t.me/"..user_info.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, 'التاريخ = '..first_n, 'md', false, false, false, false, reply_markup)
end
if text == 'الساعه' then
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_n = os.date("%I:%M:%S %p")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =user_info.first_name,url = "https://t.me/"..user_info.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, 'الساعه = '..first_n, 'md', false, false, false, false, reply_markup)
end
if text == 'اسمي' then
local user_info = LuaTele.getUser(msg.sender.user_id)
local first_n = user_info.first_name
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =user_info.first_name,url = "https://t.me/"..user_info.username..""}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, 'اسمك = '..first_n, 'md', false, false, false, false, reply_markup)
end
if text == 'ايديي' then
return LuaTele.sendText(msg_chat_id,msg_id,'\nايديك = '..msg.sender.user_id,"md",true)  
end
if text == 'صلاحياتي' then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*᪣ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✓ ❭' else change_info = '❬ ✘ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✓ ❭' else delete_messages = '❬ ✘ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✓ ❭' else invite_users = '❬ ✘ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✓ ❭' else pin_messages = '❬ ✘ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✓ ❭' else restrict_members = '❬ ✘ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✓ ❭' else promote = '❬ ✘ ❭'
end
PermissionsUser = '*\n᪣ صلاحيات المستخدم :\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n᪣ تغيير المعلومات : '..change_info..'\n᪣ تثبيت الرسائل : '..pin_messages..'\n᪣ اضافه مستخدمين : '..invite_users..'\n᪣ مسح الرسائل : '..delete_messages..'\n᪣ حظر المستخدمين : '..restrict_members..'\n᪣ اضافه المشرفين : '..promote..'\n\n*'
return LuaTele.sendText(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end
if text and text:match("^ضع عدد المسح (%d+)$") then  
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هذا الامر يخص { '..Controller_Num(5)..' }* ',"md",true)  
end
local Numbardel = text:match("^ضع عدد المسح (%d+)$")
Redis:set(Timo.."allM:numdel"..msg.chat_id,Numbardel) 
LuaTele.sendText(msg_chat_id,msg_id, 'تم تعيين العدد  الى : '..Numbardel)
end
if text == ("امسح") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
local list = Redis:smembers(Timo.."allM"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = "᪣ تم مسح "..k.." من الوسائط الموجوده"
LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Timo.."allM"..msg.chat_id)
end
end
if #list == 0 then
t = "᪣ لا يوجد ميديا في الجروب"
end
 LuaTele.sendText(msg_chat_id,msg_id, t)
end
if text == ("الميديا") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
local gmria = Redis:scard(Timo.."allM"..msg.chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,"᪣ عدد الميديا الموجود هو (* "..gmria.." *)","md")
end
if text == "تعطيل المسح التلقائي" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(3)..' }* ',"md",true)  
end
Redis:del(Timo.."Status:Del:Media"..msg.chat_id)
 LuaTele.sendText(msg_chat_id,msg_id,'᪣ تم تعطيل المسح التلقائي للميديا')
return false
end 
if text == "تفعيل المسح التلقائي" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(3)..' }* ',"md",true)  
end
Redis:set(Timo.."Status:Del:Media"..msg.chat_id,true)
LuaTele.sendText(msg_chat_id,msg_id,'᪣ تم تفعيل المسح التلقائي للميديا')
return false
end 

if text == 'كشف البوت' then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,Timo).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ البوت عضو في الجروب ',"md",true) 
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Timo).status
if GetMemberStatus.can_change_info then
change_info = '【 ✅ 】' else change_info = '【 ❌ 】'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '【 ✅ 】' else delete_messages = '【 ❌ 】'
end
if GetMemberStatus.can_invite_users then
invite_users = '【 ✅ 】' else invite_users = '【 ❌ 】'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '【 ✅ 】' else pin_messages = '【 ❌ 】'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '【 ✅ 】' else restrict_members = '【 ❌ 】'
end
if GetMemberStatus.can_promote_members then
promote = '【 ✅ 】' else promote = '【 ❌ 】'
end
PermissionsUser = '*\n ᪣ صلاحيات البوت في الجروب :\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘'..'\n ᪣ تغيير المعلومات : '..change_info..'\n ᪣ تثبيت الرسائل : '..pin_messages..'\n ᪣ اضافه مستخدمين : '..invite_users..'\n ᪣ مسح الرسائل : '..delete_messages..'\n ᪣ حظر المستخدمين : '..restrict_members..'\n ᪣ اضافه المشرفين : '..promote..'\n\n*'
return LuaTele.sendText(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end

if text and text:match('^مسح (%d+)$') then
local NumMessage = text:match('^مسح (%d+)$')
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ العدد اكثر من 1000 لا تستطيع الحذف',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
var(deleteMessages)
Message = Message - 1048576
end
LuaTele.sendText(msg_chat_id, msg_id, " ᪣ تم تنظيف - "..NumMessage.. ' رساله', 'md')
end

if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:DevelopersQ:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"* ᪣ تم تنزيله مطور ثانوي مسبقا *").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:DevelopersQ:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"* ᪣ تم تنزيله مطور ثانوي *").Reply,"md",true)  
end
end
if UserName[1]  == 'مساعد' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(Timo..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."HELPBEVQ:Groups",bana.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(bana.id,"᪣ تم تنزيله مساعد مسبقا ").Reply,"md",true)  
else
Redis:del(Timo.."HELPBEVQ:Groups")
Redis:del(Timo.."HELPBEVQ:Groups", bana.id)
Redis:del(Timo.."id:HELPBEVQ:Groups", bana.id)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(bana.id,"᪣ تم تنزيله مساعد").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Developers:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Developers:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(3)..' 𓄹* ',"md",true)  
end
if not Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:TheBasics:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:DevelopersQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:DevelopersQ:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مساعد' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(Timo..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."HELPBEVQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"᪣ تم تنزيله مساعد مسبقا ").Reply,"md",true)  
else
Redis:del(Timo.."HELPBEVQ:Groups")
Redis:del(Timo.."HELPBEVQ:Groups", Message_Reply.sender.user_id)
Redis:del(Timo.."id:HELPBEVQ:Groups", Message_Reply.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"᪣ تم تنزيله مساعد").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Developers:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Developers:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(3)..' 𓄹* ',"md",true)  
end
if not Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end


if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local ban = LuaTele.getUser(UserId[2])
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:DevelopersQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"* ᪣ تم تنزيله مطور ثانوي مسبقا *").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:DevelopersQ:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"* ᪣ تم تنزيله مطور ثانوي *").Reply,"md",true)  
end
end
if UserId[1] == 'مساعد' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(Timo..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."HELPBEVQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"᪣ تم تنزيله مساعد مسبقا ").Reply,"md",true)  
else
Redis:del(Timo.."HELPBEVQ:Groups")
Redis:del(Timo.."HELPBEVQ:Groups", UserId)
Redis:del(Timo.."id:HELPBEVQ:Groups", UserId)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"᪣ تم تنزيله مساعد").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Developers:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Developers:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(3)..' 𓄹* ',"md",true)  
end
if not Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:TheBasics:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:DevelopersQ:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:DevelopersQ:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مساعد" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(Timo..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."HELPBEVQ:Groups",bana.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(bana.id,"᪣ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:del(Timo.."HELPBEVQ:Groups")
Redis:sadd(Timo.."HELPBEVQ:Groups", UserId)
Redis:set(Timo.."id:HELPBEVQ:Groups", UserId)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(bana.id,"᪣ تم ترقيته مساعد").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Developers:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Developers:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(3)..' 𓄹* ',"md",true)  
end
if Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:TheBasics:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Originators:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Managers:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Addictive:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Distinguished:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:DevelopersQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:DevelopersQ:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مساعد' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(Timo..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."HELPBEVQ:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"᪣ تم ترقيته مساعد مسبقا ").Reply,"md",true)  
else
Redis:del(Timo.."HELPBEVQ:Groups")
Redis:sadd(Timo.."HELPBEVQ:Groups", Message_Reply.sender.user_id)
Redis:set(Timo.."id:HELPBEVQ:Groups", Message_Reply.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"᪣ تم ترقيته  مساعد").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Developers:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Developers:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(3)..' 𓄹* ',"md",true)  
end
if Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:TheBasics:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Originators:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Managers:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Addictive:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Distinguished:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local ban = LuaTele.getUser(UserId[2])
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:DevelopersQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:DevelopersQ:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مساعد' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(Timo..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."HELPBEVQ:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"᪣ تم ترقيته مساعد مسبقا ").Reply,"md",true)  
else
Redis:del(Timo.."HELPBEVQ:Groups")
Redis:sadd(Timo.."HELPBEVQ:Groups", UserId)
Redis:set(Timo.."id:HELPBEVQ:Groups", UserId)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId,"᪣ تم مساعد").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Developers:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Developers:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(3)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:TheBasics:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Originators:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Managers:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Addictive:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:SetId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id,UserId[2]) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:Distinguished:Group"..msg_chat_id,UserId[2]) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[2]," ᪣ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
if text and text:match("^تغير رد المطور (.*)$") then
local Teext = text:match("^تغير رد المطور (.*)$") 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:set(Timo.."Timo:Developer:Bot:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغير رد المطور الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ الاساسي (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
local Teext = text:match("^تغير رد المنشئ الاساسي (.*)$") 
Redis:set(Timo.."Timo:President:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغير رد المنشئ (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
local Teext = text:match("^تغير رد المنشئ (.*)$") 
Redis:set(Timo.."Timo:Constructor:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغير رد المالك (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
local Teext = text:match("^تغير رد المالك (.*)$") 
Redis:set(Timo.."Timo:PresidentQ:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغير رد المالك الى :"..Teext)
elseif text and text:match("^تغير رد المدير (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
local Teext = text:match("^تغير رد المدير (.*)$") 
Redis:set(Timo.."Timo:Manager:Group:Reply"..msg.chat_id,Teext) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغير رد المدير الى :"..Teext)
elseif text and text:match("^تغير رد الادمن (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
local Teext = text:match("^تغير رد الادمن (.*)$") 
Redis:set(Timo.."Timo:Admin:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغير رد الادمن الى :"..Teext)
elseif text and text:match("^تغير رد المميز (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
local Teext = text:match("^تغير رد المميز (.*)$") 
Redis:set(Timo.."Timo:Vip:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغير رد المميز الى :"..Teext)
elseif text and text:match("^تغير رد العضو (.*)$") then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
local Teext = text:match("^تغير رد العضو (.*)$") 
Redis:set(Timo.."Timo:Mempar:Group:Reply"..msg.chat_id,Teext)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:del(Timo.."Timo:Developer:Bot:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:del(Timo.."Timo:President:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المالك' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:del(Timo.."Timo:PresidentQ:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم حذف رد المالك ")
elseif text == 'حذف رد المنشئ' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:del(Timo.."Timo:Constructor:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:del(Timo.."Timo:Manager:Group:Reply"..msg.chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:del(Timo.."Timo:Admin:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:del(Timo.."Timo:Vip:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم حذف رد المميز")
elseif text == 'حذف رد العضو' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* 𓄼๏?? هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
Redis:del(Timo.."Timo:Mempar:Group:Reply"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم حذف رد العضو")
end
if text == 'الثانوين' or text == 'المطورين الثانوين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"*᪣ لا يوجد مطورين ثانوين في البوت*","md",true)  
end
ListMembers = '\n* قائمه المطورين الثانوين ⇧⇩* \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح الثانوين ᪣', data = msg.sender.user_id..'/DevelopersQ'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"*᪣ لا يوجد مطورين في البوت*","md",true)  
end
ListMembers = '\n* ᪣ قائمه مطورين البوت ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المطورين ᪣', data = msg.sender.user_id..'/Developers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المالكين' then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(3)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد مالكين في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه المالكين في البوت ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المالكين ᪣', data = msg.sender.user_id..'/TheBasicsQ'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد منشئين اساسيين في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه المنشئين الاساسيين ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المنشئين الاساسيين ᪣', data = msg.sender.user_id..'/TheBasics'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين' then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد منشئين في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه المنشئين في البوت ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المنشئين ᪣', data = msg.sender.user_id..'/Originators'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المدراء' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد مدراء في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه المدراء في البوت ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المدراء ᪣', data = msg.sender.user_id..'/Managers'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد ادمنيه في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه الادمنيه في البوت ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح الادمنيه ᪣', data = msg.sender.user_id..'/Addictive'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد مميزين في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه المميزين في البوت ⇧⇩*\n⩹┉┉┉┉⊶❲𖥳 𝐒𝐀??𝐃𝐈 𖥳❳⊷┉┉┉┉⩺\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المميزين ᪣', data = msg.sender.user_id..'/DelDistinguished'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد محظورين عام في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه المحظورين عام ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المحظورين عام ᪣', data = msg.sender.user_id..'/BanAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:ktmAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مكتومين عام في البوت ","md",true)  
end
ListMembers = '\n* ᪣ قائمه المكتومين عام ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المكتومين عام ᪣', data = msg.sender.user_id..'/ktmAll'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد محظورين في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه المحظورين في البوت ⇧⇩*\n⩹┉┉┉┉⊶❲𖥳 𝐒𝐀?????? 𖥳❳⊷┉┉┉┉⩺\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المحظورين ᪣', data = msg.sender.user_id..'/BanGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد مكتومين في البوت *","md",true)  
end
ListMembers = '\n* ᪣ قائمه المكتومين في البوت ⇧⇩*\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
for k, v in pairs(Info_Members) do
local ban = LuaTele.getUser(v)
if ban and ban.username and ban.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..ban.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '᪣ مسح المكتومين ᪣', data = msg.sender.user_id..'/SilentGroupGroup'},},}}
return LuaTele.sendText(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:set(Timo.."Timo:Status:Link"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الرابط *","md",true)
end
if TextMsg == 'الترحيب' then
Redis:set(Timo.."Timo:Status:Welcome"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الترحيب *","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Status:Id"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الايدي *","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Status:IdPhoto"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الايدي بالصوره *","md",true)
end
if TextMsg == 'الردود المضافه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Status:Reply"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الردود *","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Status:ReplySudo"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الردود العامه *","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Status:BanId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الحظر , الطرد , التقييد*","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Status:SetId"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الرفع *","md",true)
end
if TextMsg == 'الالعاب' then
Redis:set(Timo.."Timo:Status:Games"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل الالعاب *","md",true)
end
if TextMsg == 'التحقق' then
Redis:set(Timo.."Timo:Status:joinet"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل التحقق *","md",true)
end
if TextMsg == 'اطردني' then
Redis:set(Timo.."Timo:Status:KickMe"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل اطردني *","md",true)
end
if TextMsg == 'صورتي' then
Redis:set(Timo.."Status:photo"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"᪣ تم تفعيل صورتي ","md",true)
end
if TextMsg == 'قول' then
Redis:set(Timo.."Status:kool"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"᪣ تم تفعيل امر قول ","md",true)
end
if TextMsg == 'جمالي' then
Redis:set(Timo.."Status:gamle"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"᪣ تم تفعيل جمالي ","md",true)
end
if TextMsg == 'ردود السورس' then
Redis:set(Timo.."Timo:Sasa:Jeka"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل ردود السورس *","md",true)
end
if TextMsg == 'نزلني' then
Redis:set(Timo.."Timo:Status:remMe"..msg_chat_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل نزلني *","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:BotFree",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل البوت الخدمي *","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:TwaslBot",true) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تفعيل التواصل داخل البوت *","md",true)
end

end

if text and text:match("^(.*)$") then
if Redis:get(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:set(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id, "true1")
Redis:set(Timo.."Timo1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id, text)
Redis:sadd(Timo.."Timo1:List:Rd:Sudo"..msg.chat_id, text)
return  LuaTele.sendText(msg_chat_id,msg_id, '\nارسل لي الكلمه الان ') 
end
end
if text and text:match("^(.*)$") then
if Redis:get(Timo.."Timo1:Set:On"..msg.sender.user_id..":"..msg.chat_id) == "true" then
Redis:del(Timo..'Timo1:Add:Rd:Sudo:Text'..text..msg.chat_id)
Redis:del(Timo..'Timo1:Add:Rd:Sudo:Text1'..text..msg.chat_id)
Redis:del(Timo..'Timo1:Add:Rd:Sudo:Text2'..text..msg.chat_id)
Redis:del(Timo.."Timo1:Set:On"..msg.sender.user_id..":"..msg.chat_id)
Redis:srem(Timo.."Timo1:List:Rd:Sudo"..msg.chat_id, text)
return  LuaTele.sendText(msg_chat_id,msg_id,"تم حذف الرد من ردود المتعدده")
end
end
if text == "مسح الردود المتعدده" or text == "مسح ردود المتعدده" or text ==  "مسح الردود المتعدد" or text == "مسح ردود متعدد" then     
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(6)..' }* ',"md",true)  
end
local list = Redis:smembers(Timo.."Timo1:List:Rd:Sudo"..msg.chat_id)
for k,v in pairs(list) do  
Redis:del(Timo.."Timo1:Add:Rd:Sudo:Text"..v..msg.chat_id) 
Redis:del(Timo.."Timo1:Add:Rd:Sudo:Text1"..v..msg.chat_id) 
Redis:del(Timo.."Timo1:Add:Rd:Sudo:Text2"..v..msg.chat_id) 
Redis:del(Timo.."Timo1:List:Rd:Sudo"..msg.chat_id)
end
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف ردود المتعدده")
end
if text == "الردود المتعدده" or text == "ردود المتعدده" or text ==  "الردود المتعدد" or text == "ردود متعدد" then    
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(6)..' }* ',"md",true)  
end
local list = Redis:smembers(Timo.."Timo1:List:Rd:Sudo"..msg.chat_id)
text = "\nقائمه الردود المتعدده ⇧⇩\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." -›〘 "..v.." 〙-›〘 "..db.." 〙\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
 LuaTele.sendText(msg_chat_id,msg_id," "..text.." ")
end
if text == "اضف رد متعدد" or text == "ضع رد متعدد" then   
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(6)..' 〙* ',"md",true)  
end
Redis:set(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الرد الذي اريد اضافته")
end
if text == "حذف ردم متعدد" or text == "مسح رد متعدد" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(6)..' 〙* ',"md",true)  
end
Redis:set(Timo.."Timo1:Set:On"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الان الكلمه لحذفها ")
end
if text then  
local test = Redis:get(Timo.."Timo1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
Redis:set(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Timo.."Timo1:Add:Rd:Sudo:Text"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = Redis:get(Timo.."Timo1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd1" then
Redis:set(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Timo.."Timo1:Add:Rd:Sudo:Text1"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = Redis:get(Timo.."Timo1:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd2" then
Redis:set(Timo.."Timo1:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Timo.."Timo1:Add:Rd:Sudo:Text2"..test..msg.chat_id, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد")
return false  
end  
end
if text then
local Text = Redis:get(Timo.."Timo1:Add:Rd:Sudo:Text"..text..msg.chat_id)   
local Text1 = Redis:get(Timo.."Timo1:Add:Rd:Sudo:Text1"..text..msg.chat_id)   
local Text2 = Redis:get(Timo.."Timo1:Add:Rd:Sudo:Text2"..text..msg.chat_id)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
 LuaTele.sendText(msg_chat_id,msg_id,texting[Textes])
end
end
if text and text:match("^(.*)$") then
if Redis:get(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true" then
 LuaTele.sendText(msg_chat_id,msg_id, '\nارسل لي الكلمه الان ')
Redis:set(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id, "true1")
Redis:set(Timo.."Timo11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id, text)
Redis:sadd(Timo.."Timo11:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if Redis:get(Timo.."Timo11:Set:On"..msg.sender.user_id..":"..msg.chat_id) == "true" then
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف الرد من ردود المتعدده")
Redis:del(Timo..'Timo11:Add:Rd:Sudo:Text'..text)
Redis:del(Timo..'Timo11:Add:Rd:Sudo:Text1'..text)
Redis:del(Timo..'Timo11:Add:Rd:Sudo:Text2'..text)
Redis:del(Timo.."Timo11:Set:On"..msg.sender.user_id..":"..msg.chat_id)
Redis:srem(Timo.."Timo11:List:Rd:Sudo", text)
return false
end
end
if text == "مسح الردود المتعدده عام" or text == "مسح ردود المتعدده عام" or text ==  "مسح الردود المتعدد عام" or text == "مسح ردود متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(1)..' 〙* ',"md",true)  
end
local list = Redis:smembers(Timo.."Timo11:List:Rd:Sudo")
for k,v in pairs(list) do  
Redis:del(Timo.."Timo11:Add:Rd:Sudo:Text"..v) 
Redis:del(Timo.."Timo11:Add:Rd:Sudo:Text1"..v) 
Redis:del(Timo.."Timo11:Add:Rd:Sudo:Text2"..v)   
Redis:del(Timo.."Timo11:List:Rd:Sudo")
end
 LuaTele.sendText(msg_chat_id,msg_id,"تم حذف ردود المتعدده")
end
if text == "الردود المتعدده عام" or text == "ردود المتعدده عام" or text ==  "الردود المتعدد عام" or text == "ردود متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(1)..' 〙* ',"md",true)  
end
local list = Redis:smembers(Timo.."Timo11:List:Rd:Sudo")
text = "\nقائمه الردود المتعدده عام ⇧⇩\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." -›〘 "..v.." 〙-›〘 "..db.." 〙\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده عام"
end
 LuaTele.sendText(msg_chat_id,msg_id," "..text.." ")
end
if text == "اضف رد متعدد عام" or text == "وضع رد متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(1)..' 〙* ',"md",true)  
end
Redis:set(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد عام" or text == "حذف رد متعدد عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(1)..' 〙* ',"md",true)  
end
Redis:set(Timo.."Timo11:Set:On"..msg.sender.user_id..":"..msg.chat_id,true)
return  LuaTele.sendText(msg_chat_id,msg_id,"ارسل الان الكلمه لحذفها ")
end
if text then  
local test = Redis:get(Timo.."Timo11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "true1" then
Redis:set(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Timo.."Timo11:Add:Rd:Sudo:Text"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = Redis:get(Timo.."Timo11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd1" then
Redis:set(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Timo.."Timo11:Add:Rd:Sudo:Text1"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = Redis:get(Timo.."Timo11:Text:Sudo:Bot"..msg.sender.user_id..":"..msg.chat_id)
if Redis:get(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id) == "rd2" then
Redis:set(Timo.."Timo11:Set:Rd"..msg.sender.user_id..":"..msg.chat_id,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(Timo.."Timo11:Add:Rd:Sudo:Text2"..test, text)  
end  
 LuaTele.sendText(msg_chat_id,msg_id,"تم حفظ الرد")
return false  
end  
end
if text then
local Text = Redis:get(Timo.."Timo11:Add:Rd:Sudo:Text"..text)   
local Text1 = Redis:get(Timo.."Timo11:Add:Rd:Sudo:Text1"..text)   
local Text2 = Redis:get(Timo.."Timo11:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
 LuaTele.sendText(msg_chat_id,msg_id,texting[Textes])
end
end
 
if msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then      
Redis:sadd(Timo.."Timo:allM"..msg.chat_id, msg.id)
if Redis:get(Timo.."Timo:Status:Del:Media"..msg.chat_id) then    
local gmedia = Redis:scard(Timo.."Timo:allM"..msg.chat_id)  
if gmedia >= 200 then
local liste = Redis:smembers(Timo.."Timo:allM"..msg.chat_id)
for k,v in pairs(liste) do
local Mesge = v
if Mesge then
t = " ᪣ تم مسح "..k.." من الوسائط تلقائيا\n ᪣ يمكنك تعطيل الميزه بستخدام الامر ( `تعطيل المسح التلقائي` )"
LuaTele.deleteMessages(msg.chat_id,{[1]= Mesge})
end
end
LuaTele.sendText(msg_chat_id,msg_id, t)
Redis:del(Timo.."Timo:allM"..msg.chat_id)
end
end
end

if text == "مسح الميديا" then  
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 〘 '..Controller_Num(4)..' 〙* ',"md",true)  
end
local list = Redis:smembers(Timo.."Timo:allM"..msg.chat_id)
for k,v in pairs(list) do
local Message = v
if Message then
t = " ᪣ تم مسح "..k.." من الوسائط الموجوده"
LuaTele.deleteMessages(msg.chat_id,{[1]= Message})
Redis:del(Timo.."Timo:allM"..msg.chat_id)
end
end
if #list == 0 then
t = " ᪣ لا يوجد ميديا في المجموعه"
end
 LuaTele.sendText(msg_chat_id,msg_id, t)
end
if text == "عدد الميديا" then  
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 〘 '..Controller_Num(4)..' 〙* ',"md",true)  
end
local gmria = Redis:scard(Timo.."Timo:allM"..msg.chat_id)  
 LuaTele.sendText(msg_chat_id,msg_id,"᪣ عدد الميديا الموجود هو〘* "..gmria.." *〙","md")
end
if text == "تعطيل المسح التلقائي" then        
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 〘 '..Controller_Num(4)..' 〙* ',"md",true)  
end
Redis:del(Timo.."Timo:Status:Del:Media"..msg.chat_id)
 LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم تعطيل المسح التلقائي للميديا')
return false
end 
if text == "تفعيل المسح التلقائي" then        
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 〘 '..Controller_Num(4)..' 〙* ',"md",true)  
end
Redis:set(Timo.."Timo:Status:Del:Media"..msg.chat_id,true)
LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم تفعيل المسح التلقائي للميديا')
return false
end 
if text == "تعطيل اليوتيوب" then        
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 〘 '..Controller_Num(6)..' 〙* ',"md",true)  
end
Redis:del(Timo.."Timo:Status:yt"..msg.chat_id)
 LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم تعطيل المسح اليوتيوب')
return false
end 
if text == "تفعيل اليوتيوب" then        
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 〘 '..Controller_Num(6)..' 〙* ',"md",true)  
end
Redis:set(Timo.."Timo:Status:yt"..msg.chat_id,true)
LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم تفعيل اليوتيوب')
return false
end 
if text and text:match('^بحث (.*)$') then
local search = text:match('^بحث (.*)$')
https.request("https://core1.tk/apies/youtube/script.php?token="..Token.."&chat="..msg_chat_id.."&text="..URL.escape(search))
end

if text == "يوتيوب" then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تحميل صوت', data = msg.sender.user_id..'/mp3'..msg_id}, {text = 'تحميل فيديو', data = msg.sender.user_id..'/mp4'..msg_id}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
◍ اختر كيف تريد التحميل
*]],"md",false, false, false, false, reply_markup)
end

if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:del(Timo.."Timo:Status:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الرابط *","md",true)
end
if TextMsg == 'الترحيب' then
Redis:del(Timo.."Timo:Status:Welcome"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الترحيب *","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Status:Id"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الايدي *","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Status:IdPhoto"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الايدي بالصوره *","md",true)
end
if TextMsg == 'الردود المضافه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Status:Reply"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الردود *","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Status:ReplySudo"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الردود العامه *","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Status:BanId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الحظر , الطرد , التقييد*","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Status:SetId"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الرفع *","md",true)
end
if TextMsg == 'الالعاب' then
Redis:del(Timo.."Timo:Status:Games"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل الالعاب *","md",true)
end
if TextMsg == 'التحقق' then
Redis:del(Timo.."Timo:Status:joinet"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل التحقق *","md",true)
end
if TextMsg == 'اطردني' then
Redis:del(Timo.."Timo:Status:KickMe"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل اطردني *","md",true)
end
if TextMsg == 'صورتي' then
Redis:del(Timo.."Status:photo"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"᪣ تم تعطيل صورتي ","md",true)
end
if TextMsg == 'قول' then
Redis:del(Timo.."Status:kool"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"᪣ تم تعطيل امر قول ","md",true)
end
if TextMsg == 'جمالي' then
Redis:del(Timo.."Status:gamle"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"᪣ تم تعطيل جمالي ","md",true)
end
if TextMsg == 'ردود السورس' then
Redis:del(Timo.."Timo:Sasa:Jeka"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل ردود السورس *","md",true)
end
if TextMsg == 'نزلني' then
Redis:del(Timo.."Timo:Status:remMe"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل نزلني *","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:BotFree") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل البوت الخدمي *","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:TwaslBot") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم تعطيل التواصل داخل البوت *","md",true)
end

end

if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المبرمج تيمو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المبرمج سيزر' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:BanAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"* ᪣ تم حظره عام من المجموعات *").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:BanAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام @(%S+)$') then
local UserName = text:match('^كتم عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المبرمج تيمو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المبرمج سيزر' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:ktmAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:ktmAll:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم عام @(%S+)$') then
local UserName = text:match('^الغاء كتم عام @(%S+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:ktmAll:Groups",UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:ktmAll:Groups",UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم حظره من الجروب ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء حظره من الجروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم?? "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم كتمه في الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم كتمه في الجروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء كتمه من الجروب ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء كتمه من الجروب ").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName[3])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع تقييد𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تقييده في الجروب \n ᪣ لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع تقييد𓄼"..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تقييده في الجروب \n ᪣ لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local ban = LuaTele.getUser(UserId[3])
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع تقييد 𓄼 "..Controller(msg_chat_id,UserId[3]).." 𓄹*","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n ᪣ تم تقييده في الجروب \n ᪣ لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع تقييد𓄼 "..Controller(msg_chat_id,UserId_Info.id).." 𓄹*","md",true)  
              end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تقييده في الجروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم الغاء تقييده من الجروب").Reply,"md",true)  
end

if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المبرمج تيمو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المبرمج سيزر' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:BanAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء العام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:BanAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص ?? '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المبرمج تيمو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المبرمج سيزر' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:ktmAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:ktmAll:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:ktmAll:Groups",Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:ktmAll:Groups",Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم حظره من الجروب ").Reply,"md",true)  
end
end
if text == ('الغاء حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء حظره من الجروب  ").Reply,"md",true)  
end
end

if text == ('كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم كتمه في الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم كتمه في الجروب  ").Reply,"md",true)  
end
end
if text == ('الغاء كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء كتمه من الجروب ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء كتمه من الجروب ").Reply,"md",true)  
end
end

if text == ('تقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع تقييد𓄼"..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تقييده في الجروب ").Reply,"md",true)  
end

if text == ('الغاء التقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء تقييده من الجروب").Reply,"md",true)  
end

if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع طرد𓄼 "..Controller(msg_chat_id,Message_Reply.sender.user_id).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:MosTafa:Ahmed"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم طرد من الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:MosTafa:Ahmed"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"* ᪣ تم طرده من الجروب *").Reply,"md",true)  
end
end

if text == ('الغاء طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(Timo.."Timo:MosTafa:Ahmed"..msg_chat_id,Message_Reply.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء طردن من الجروب مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:MosTafa:Ahmed"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم الغاء طرده من الجروب  ").Reply,"md",true)  
end
end

if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'المبرمج تيمو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'المبرمج سيزر' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع حظر عام𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:BanAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Timo.."Timo:BanAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام (%d+)$') then
local UserId = text:match('^كتم عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم  عام𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'المطور الثانوي' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا لا تستطيع كتم  عام𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'المبرمج تيمو' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Controller(msg_chat_id,UserId) == 'المبرمج سيزر' then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ᪣ عذرا لا تستطيع كتم عام𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:ktmAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:ktmAll:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم عام (%d+)$') then
local UserId = text:match('^الغاء كتم عام (%d+)$')
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Timo.."Timo:ktmAll:Groups",UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:ktmAll:Groups",UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ᪣ عذرا لا تستطيع حظر𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم حظره من الجروب ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء حظره من الجروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ᪣ عذرا لا تستطيع كتم𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
if Redis:sismember(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم كتمه في الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم كتمه في الجروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء كتمه من الجروب ").Reply,"md",true)  
else
Redis:srem(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId) 
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء كتمه من الجروب ").Reply,"md",true)  
end
end

if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Originators and not Redis:get(Timo.."Timo:Status:BanId"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل 𓄼الحظر : الطرد : التقييد𓄹 من قبل المدراء","md",true)
end 
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*  ᪣ عذرا لا تستطيع تقييد𓄼 "..Controller(msg_chat_id,UserId).." 𓄹*","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم تقييده في الجروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local ban = LuaTele.getUser(UserId)
if ban.luatele == "error" and ban.code == 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام ايدي خطأ ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId," ᪣ تم الغاء تقييده من الجروب").Reply,"md",true)  
end

if text == "نزلني" then
if not Redis:get(Timo.."Timo:Status:remMe"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ امر نزلني تم تعطيله من قبل المدراء *","md",true)  
end
if The_ControllerAll(msg.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(Timo.."Timo:DevelopersQ:Groups",msg.sender.user_id)  then
Rink = 2
elseif Redis:sismember(Timo.."Timo:Developers:Groups",msg.sender.user_id)  then
Rink = 3
elseif Redis:sismember(Timo.."Timo:TheBasicsQ:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 4
elseif Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 5
elseif Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 6
elseif Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 7
elseif Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 8
elseif Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 9
else
Rink = 10
end
if Rink == 10 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ ليس لديك رتب عزيزي *","md",true)  
end
if Rink <= 7  then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ استطيع تنزيل الادمنيه والمميزين فقط","md",true) 
else
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, msg.sender.user_id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, msg.sender.user_id)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تنزيلك من الادمنيه والمميزين ","md",true) 
end
end

if text == "اطردني" or text == "طلعني" or text == "خرجني" then 
if not Redis:get(Timo.."Timo:Status:KickMe"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"*⌔︙امر اطردني تم تعطيله من قبل المدراء *","md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*⌔︙عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*⌔︙البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if StatusCanOrNotCan(msg_chat_id,msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*⌔︙عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,msg.sender.user_id).." } *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
KickMe = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
KickMe = true
else
KickMe = false
end
if KickMe == true then
return LuaTele.sendText(msg_chat_id,msg_id,"*⌔︙عذرا لا استطيع طرد ادمنيه ومنشئين الجروب*","md",true)    
end
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"⌔︙").Reply,"md",true)  
end
if text == 'ادمنيه الجروب' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n* ᪣ قائمه الادمنيه \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘*\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→ *{ المالك }*'
else
Creator = ""
end
local ban = LuaTele.getUser(v.member_id.user_id)
if ban.username ~= "" then
listAdmin = listAdmin.."*"..k.." - @SU_SELVA"..Creator.."\n"
else
listAdmin = listAdmin.."*"..k.." - *["..ban.id.."](tg://user?id="..ban.id..") "..Creator.."\n"
end
end
LuaTele.sendText(msg_chat_id,msg_id,listAdmin,"md",true)  
end

if text == 'رفع الادمنيه' or text == 'ترقيه الادمنيه' or text == 'رفع المالك' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(Timo.."Timo:TheBasics:Group"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
Redis:sadd(Timo.."Timo:Addictive:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ تم ترقيه - ('..y..') ادمنيه *',"md",true)  
end

if text == "صورتي" then
if Redis:get(Timo.."Status:photo"..msg.chat_id) then
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local ban = LuaTele.getUser(msg.sender.user_id)
local ban_ns = '᪣ ʜᴇʀᴇ ᴀʀᴇ ʏᴏ𝗎ʀ ᴘʜᴏᴛᴏѕ'
if photo.total_count > 0 then
data = {} 
data.inline_keyboard = {
{
{text = '𓄼 اخفاء الامر 𓄹 ', callback_data = msg.sender.user_id..'/ban88'}, 
},
{
{text = '𓄼 صورتك القادمه 𓄹', callback_data= msg.sender.user_id..'/ban1'}, 
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
end

if text == "تست" then
if Redis:get(Timo.."Status:photo"..msg.chat_id) then
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local ban = LuaTele.getUser(msg.sender.user_id)
local ban_ns = '᪣ ʜᴇʀᴇ ᴀʀᴇ ʏᴏ𝗎ʀ ᴘʜᴏᴛᴏѕ'
if photo.total_count > 0 then
data = {} 
data.inline_keyboard = {
{
{text = '𓄼 اخفاء الامر 𓄹 ', callback_data = msg.sender.user_id..'/ban88'}, 
},
{
{text = '𓄼 صورتك القادمه 𓄹', callback_data= msg.sender.user_id..'/ban89'}, 
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption=".. URL.escape(ban_ns).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
end

if text == 'كشف البوتات' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n* ᪣ قائمه البوتات \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘*\n'
x = 0
for k, v in pairs(List_Members) do
local ban = LuaTele.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
x = x + 1
Admin = '→ *{ ادمن }*'
else
Admin = ""
end
listBots = listBots.."*"..k.." - @"..ban.username.."* "..Admin.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,listBots.."*\n⩹┉┉┉┉⊶❲?? ??𝐀𝐈𝐃𝐈 ??❳⊷┉┉┉┉⩺\n ᪣ عدد البوتات التي هي ادمن ( "..x.." )*","md",true)  
end


 
if text == 'المقيدين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = nil
restricted = '\n* ᪣ قائمه المقيديين \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘*\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local ban = LuaTele.getUser(v.member_id.user_id)
if ban.username ~= "" then
restricted = restricted.."*"..x.." - @"..ban.username.."*\n"
else
restricted = restricted.."*"..x.." - *["..ban.id.."](tg://user?id="..ban.id..") \n"
end
end
end
if y == true then
LuaTele.sendText(msg_chat_id,msg_id,restricted,"md",true)  
end
end
if msg.content.photo then
if msg.content.caption.text and msg.content.caption.text:match("^all (.*)$") then
local ttag = msg.content.caption.text:match("^all (.*)$") 
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
LuaTele.sendPhoto(msg.chat_id, 0, idPhoto,Text,"md")
end 
end 
end
end
if text == "تاك للكل" or text == "all" or text == "@all" or text == "All" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 〘 '..Controller_Num(7)..' 〙* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 500)
x = 0
tags = 0
local list = Info_Members.members
for k, v in pairs(list) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if x == 10 or x == tags or k == 0 then
tags = x + 10
listall = ""
end
x = x + 1
if UserInfo.first_name ~= '' then
listall = listall.." ["..UserInfo.first_name.."](tg://user?id="..UserInfo.id.."),"
end
if x == 10 or x == tags or k == 0 then
LuaTele.sendText(msg_chat_id,msg_id,listall,"md",true)  
end
end
end
if text == "تاك للزوجات" or text == "الزوجات" then
local zwgat_list = Redis:smembers(Timo..msg_chat_id.."zwgat:")
if #zwgat_list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,'*᪣ لايوجد زوجات*',"md",true) 
end 
local zwga_list = "* ᪣ قائمة الزوجات *"..#zwgat_list.."\n*𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘*\n"
for k, v in pairs(zwgat_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
zwga_list = zwga_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
zwga_list = zwga_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,zwga_list,"md",true) 
end
if text == "تاك للمتوحدين" or text == "المتوحدين" then
local lonely_list = Redis:smembers(Timo..msg_chat_id.."lonely:")
if #lonely_list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,'*᪣ لايوجد متوحدين *',"md",true) 
end 
local lone_list = "* ᪣ قائمة متوحدين الجروب *"..#lonely_list.."\n*𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘*\n"
for k, v in pairs(lonely_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
lone_list = lone_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
lone_list = lone_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,lone_list,"md",true) 
end
if text == "تاك للمطلقات" or text == "المطلقات" then
local mutlqat_list = Redis:smembers(Timo..msg_chat_id.."mutlqat:")
if #mutlqat_list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,'*᪣ لايوجد مطلقات*',"md",true) 
end 
local mutlqa_list = "* ᪣ قائمة المطلقات *"..#mutlqat_list.."\n*𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘*\n"
for k, v in pairs(mutlqat_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
mutlqa_list = mutlqa_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
mutlqa_list = mutlqa_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,mutlqa_list,"md",true) 
end
if text == "تاك للكلاب" or text == "الكلاب" then
local klbklb_list = Redis:smembers(Timo..msg_chat_id.."klbklb:")
if #klbklb_list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,'*᪣ لايوجد الكلاب *',"md",true) 
end 
local klbk_list = "* ᪣ قائمة الكلاب الجروب *"..#klbklb_list.."\n*𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘*\n"
for k, v in pairs(klbklb_list) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
klbk_list = klbk_list.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
klbk_list = klbk_list.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
return LuaTele.sendText(msg_chat_id,msg_id,klbk_list,"md",true) 
end

if text == "القناه المضافه" then
return LuaTele.sendText(msg_chat_id,msg_id,Redis:get(Timo.."chadmin"..msg_chat_id),"md",true)  
end
if text == "اضف قناه" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص「 '..Controller_Num(7)..' 」* ',"md",true)  
end
Redis:set(Timo.."addchannel"..msg.sender.user_id,"on") 
LuaTele.sendText(msg_chat_id,msg_id,"᪣  ارسل ايدي القناه","md",true)  
end
if text == "قفل القناه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص「 '..Controller_Num(7)..' 」* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Timo.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Lock:channell"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"᪣ تم قفـل القنوات").Lock,"md",true)  
return false
end 
if text == "قفل الدردشه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:text"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الدردشه").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Timo.."Timo:Lock:AddMempar"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدخول" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Timo.."Timo:Lock:Join"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل دخول الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل البوتات" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Timo.."Timo:Lock:Bot:kick"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Timo.."Timo:Lock:Bot:kick"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Timo.."Timo:Lock:tagservr"..msg_chat_id,true)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الاشعارات").Lock,"md",true)  
return false
end 
if text == "تعطيل all" or text == "تعطيل @all" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص「 '..Controller_Num(6)..' 」* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Timo.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Timo.."lockalllll"..msg_chat_id,"off")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"᪣ تم قفـل @all هنا").Lock,"md",true)  
return false
end 
if text == "تفعيل all" or text == "تفعيل @all" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص「 '..Controller_Num(6)..' 」* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Timo.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Timo.."lockalllll"..msg_chat_id,"on")
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"᪣ تم فتح @all هنا").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Timo.."Timo:lockpin"..msg_chat_id,(LuaTele.getChatPinnedMessage(msg_chat_id).id or true)) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التثبيت هنا").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Timo.."Timo:Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(Timo.."Timo:Lock:edit"..msg_chat_id,true) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Timo.."Timo:Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(Timo..'Timo:'..lock..msg_chat_id,"del")    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل جميع الاوامر").Lock,"md",true)  
return false
end
if text == "تفعيل الحمايه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص ?? '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(Timo.."Timo:Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(Timo..'Timo:'..lock..msg_chat_id,"del")    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تـم تفعيل الحمايه").Lock,"md",true)  
return false
end 


--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:Lock:AddMempar"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح القناه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص「 '..Controller_Num(7)..' 」* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Timo.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Lock:channell"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"᪣ تم فتح القنوات").unLock,"md",true)  
return false
end 
if text and text:match("^وضع تكرار (%d+)$") then 
local Num = text:match("وضع تكرار (.*)")
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص「 '..Controller_Num(7)..' 」* ',"md",true)  
end
Redis:hset(Timo.."Spam:Group:User"..msg_chat_id ,"Num:Spam" ,Num) 
LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣  تم وضع عدد تكرار '..Num..'* ',"md",true)  
end
if text == "فتح الدردشه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:Lock:text"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الدردشه").unLock,"md",true)  
return false
end 
if text == "فتح الدخول" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:Lock:Join"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح دخول الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح البوتات " then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:Lock:Bot:kick"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:del(Timo.."Timo:Lock:tagservr"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فـتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:lockpin"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فـتح التثبيت هنا").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح التعديل الميديا" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:Lock:edit"..msg_chat_id) 
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(Timo.."Timo:Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(Timo..'Timo:'..lock..msg_chat_id)    
end
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فـتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Timo.."Timo:Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Timo.."Timo:Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Timo.."Timo:Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(Timo.."Timo:Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hdel(Timo.."Timo:Spam:Group:User"..msg_chat_id ,"Spam:User")  
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Link"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Link"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Link"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Link"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Link"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الروابط").unLock,"md",true)  
return false
end 
if text == "قفل المعرفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:User:Name"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:User:Name"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:User:Name"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:User:Name"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:User:Name"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:hashtak"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التاك").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:hashtak"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:hashtak"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:hashtak"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:hashtak"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Cmd"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Cmd"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Cmd"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Cmd"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Cmd"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == "قفل الصور"then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Photo"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' ??* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Photo"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Photo"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Photo"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," 𓄼๏?? تم قفـل الصور").lockKick,"md",true)  
return false
end 
if text == "فتح الصور" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Photo"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Video"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Video"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Video"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Video"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Video"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Animation"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل المتحركه").Lock,"md",true)  
return false
end 
if text == "قفل المتحركه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Animation"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Animation"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Animation"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Animation"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح المتحركه").unLock,"md",true)  
return false
end 
if text == "قفل الالعاب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:geam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:geam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:geam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:geam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:geam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Audio"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Audio"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Audio"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Audio"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Audio"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:vico"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:vico"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:vico"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:vico"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:vico"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Keyboard"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Keyboard"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Keyboard"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Keyboard"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Keyboard"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Sticker"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Sticker"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Sticker"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Sticker"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Sticker"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:forward"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:forward"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:forward"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:forward"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:forward"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Document"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Document"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Document"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Document"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Document"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Unsupported"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Unsupported"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Unsupported"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Unsupported"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Unsupported"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Markdaun"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Markdaun"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Markdaun"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Markdaun"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Markdaun"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Contact"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Contact"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص ?? '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Contact"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Contact"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Contact"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Spam"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Spam"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Spam"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Spam"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Spam"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Inlen"..msg_chat_id,"del")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقيد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Inlen"..msg_chat_id,"ked")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Inlen"..msg_chat_id,"ktm")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Lock:Inlen"..msg_chat_id,"kick")  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم قفـل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Lock:Inlen"..msg_chat_id)  
LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id," ᪣ تم فتح الانلاين").unLock,"md",true)  
return false
end 
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Timo:Set:Link"..msg_chat_id..""..msg.sender.user_id,120,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ ارسل رابط الجروب او رابط قناة الجروب","md",true)  
end
if text == "مسح الرابط" or text == "حذف الرابط" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Group:Link"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم مسح الرابط ","md",true)             
end
if text == "الرابط" or text == "رابط" or text == "الينك" then
if not Redis:get(Timo.."Timo:Status:Link"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"*᪣ تم تعطيل جلب الرابط من قبل الادمنيه*","md",true)
end 
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(Timo.."Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, "*᪣ Link Group : * \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'Hussain',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"*᪣  لا استطيع جلب الرابط بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال الرابط *","md",true)
end
url = https.request('http://api.telegram.org/bot'..Token..'/getchat?chat_id='..msg_chat_id..'')
json = JSON.decode(url)
local txt = "*᪣ Link Group : * \n["..Get_Chat.title.. ']('..LinkGroup.invite_link..')'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = Get_Chat.title, url=LinkGroup.invite_link},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo=t.me/"..json.result.username.."&caption="..URL.escape(txt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if text == "اسم الجروب" or text == "اسم البار" then
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(Timo.."Timo:Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return LuaTele.sendText(msg_chat_id, msg_id, " \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'Hussain',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا استطيع جلب اسم الجروب بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال اسم الجروب ","md",true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return LuaTele.sendText(msg_chat_id, msg_id, " \n["..Get_Chat.title.. ']('..LinkGroup.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end
if text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id, 120, true)  
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ ارسل لي الترحيب الان".."\n ᪣ تستطيع اضافة مايلي !\n ᪣ دالة عرض الاسم »{`name`}\n ᪣ دالة عرض المعرف »{`user`}\n ᪣ دالة عرض اسم الجروب »{`NameCh`}","md",true)   
end
if text == "الترحيب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:get(Timo.."Timo:Status:Welcome"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تعطيل الترحيب من قبل الادمنيه","md",true)
end 
local Welcome = Redis:get(Timo.."Timo:Welcome:Group"..msg_chat_id)
if Welcome then 
return LuaTele.sendText(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لم يتم تعيين ترحيب للمجموعه","md",true)   
end 
end
if text == "مسح الترحيب" or text == "حذف الترحيب" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Welcome:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم ازالة ترحيب الجروب","md",true)   
end
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Timo:Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ ارسل لي القوانين الان","md",true)  
end
if text == "مسح القوانين" or text == "حذف القوانين" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Group:Rules"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم ازالة قوانين الجروب","md",true)    
end
if text == "القوانين" then 
local Rules = Redis:get(Timo.."Timo:Group:Rules" .. msg_chat_id)   
if Rules then     
return LuaTele.sendText(msg_chat_id,msg_id,Rules,"md",true)     
else      
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا توجد قوانين هنا","md",true)     
end    
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:setex(Timo.."Timo:Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ ارسل لي وصف الجروب الان","md",true)  
end
if text == "مسح الوصف" or text == "حذف الوصف" then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatDescription(msg_chat_id, '') 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم ازالة قوانين الجروب","md",true)    
end

if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatTitle(msg_chat_id,NameChat)
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم تغيير اسم الجروب الى : "..NameChat,"md",true)    
end

if text == ("ضع صوره") then  
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Info == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:set(Timo.."Timo:Chat:Photo"..msg_chat_id..":"..msg.sender.user_id,true) 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ ارسل الصوره لوضعها","md",true)    
end

if text == "مسح قائمه المنع" then   
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(Timo.."Timo:Filter:Group:"..v..msg_chat_id)  
Redis:srem(Timo.."Timo:List:Filter"..msg_chat_id,v)  
end  
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح ("..#list..") كلمات ممنوعه *","md",true)   
end
if text == "قائمه المنع" then   
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:List:Filter"..msg_chat_id)  
if #list == 0 then  
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
Filter = '\n* ᪣ قائمه المنع \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(Timo.."Timo:Filter:Group:"..v..msg_chat_id)   
Filter = Filter.."*"..k.."- "..ver.." » { "..Text_Filter.." }*\n"    
end  
LuaTele.sendText(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then       
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo..'Timo:FilterText'..msg_chat_id..':'..msg.sender.user_id,'true')
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end    
if text == "الغاء منع" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo..'Timo:FilterText'..msg_chat_id..':'..msg.sender.user_id,'DelFilter')
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end

if text == "اضف امر عام" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر عام" or text == "مسح امر عام" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه العامه" or text == "مسح الاوامر المضافه العامه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:All:Command:List:Group")
for k,v in pairs(list) do
Redis:del(Timo.."Timo:All:Get:Reides:Commands:Group"..v)
Redis:del(Timo.."Timo:All:Command:List:Group")
end
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم مسح جميع الاوامر التي تم اضافتها في العام","md",true)
end
if text == "الاوامر المضافه العامه" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:All:Command:List:Group")
Command = " ᪣ قائمه الاوامر المضافه العامه  \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n"
for k,v in pairs(list) do
Commands = Redis:get(Timo.."Timo:All:Get:Reides:Commands:Group"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ⇦ {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = " ᪣ لا توجد اوامر اضافيه عامه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end


if text == "اضف امر" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر" or text == "مسح امر" then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
Redis:del(Timo.."Timo:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
Redis:del(Timo.."Timo:Command:List:Group"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ تم مسح جميع الاوامر التي تم اضافتها","md",true)
end
if text == "الاوامر المضافه" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:Command:List:Group"..msg_chat_id.."")
Command = " ᪣ قائمه الاوامر المضافه  \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n"
for k,v in pairs(list) do
Commands = Redis:get(Timo.."Timo:Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ⇦ {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = " ᪣ لا توجد اوامر اضافيه"
end
return LuaTele.sendText(msg_chat_id,msg_id,Command,"md",true)
end

if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ تم تثبيت الرساله","md",true)
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end
if text == 'الغاء التثبيت' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ تم الغاء تثبيت الرساله","md",true)
LuaTele.unpinChatMessage(msg_chat_id) 
end
if text == 'الغاء تثبيت الكل' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ تم الغاء تثبيت كل الرسائل","md",true)
LuaTele.unpinAllChatMessages(msg_chat_id)
end
if text == "الحمايه" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'تعطيل الايدي', data = msg.sender.user_id..'/'.. 'unmute_Id'},{text = 'تفعيل الايدي', data = msg.sender.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود المضافه', data = msg.sender.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود المضافه', data = msg.sender.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = msg.sender.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل ردود العامه', data = msg.sender.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل ردود السورس', data = IdUser..'/'.. 'mostaf_sasa'},{text = 'تفعيل ردود السورس', data = IdUser..'/'.. 'jeka_alone'},
},
{
{text = 'تعطيل الرفع', data = msg.sender.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender.user_id..'/'.. 'mute_kickme'},
},
{
{text = '᪣ اخفاء الامر ᪣', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, ' ᪣ اوامر التفعيل والتعطيل ', 'md', false, false, false, false, reply_markup)
end  
if text == 'اعدادات الحمايه' then 
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:get(Timo.."Timo:Status:Link"..msg.chat_id) then
Statuslink = '【 ✅ 】' else Statuslink = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:Welcome"..msg.chat_id) then
StatusWelcome = '【 ✅ 】' else StatusWelcome = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:Id"..msg.chat_id) then
StatusId = '【 ✅ 】' else StatusId = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = '【 ✅ 】' else StatusIdPhoto = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:Reply"..msg.chat_id) then
StatusReply = '【 ✅ 】' else StatusReply = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = '【 ✅ 】' else StatusReplySudo = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:BanId"..msg.chat_id)  then
StatusBanId = '【 ✅ 】' else StatusBanId = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:SetId"..msg.chat_id) then
StatusSetId = '【 ✅ 】' else StatusSetId = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:Games"..msg.chat_id) then
StatusGames = '【 ✅ 】' else StatusGames = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:KickMe"..msg.chat_id) then
Statuskickme = '【 ✅ 】' else Statuskickme = '【 ❌ 】'
end
if Redis:get(Timo.."Timo:Status:AddMe"..msg.chat_id) then
StatusAddme = '【 ✅ 】' else StatusAddme = '【 ❌ 】'
end
local protectionGroup = '\n* ᪣ اعدادات حمايه الجروب\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n'
..'\n ᪣ جلب الرابط⇦ '..Statuslink
..'\n ᪣ جلب الترحيب⇦ '..StatusWelcome
..'\n ᪣ الايدي⇦ '..StatusId
..'\n ᪣ الايدي بالصوره⇦ '..StatusIdPhoto
..'\n ᪣ الردود المضافه⇦ '..StatusReply
..'\n ᪣ الردود العامه⇦ '..StatusReplySudo
..'\n ᪣ الرفع⇦ '..StatusSetId
..'\n ᪣ الحظر - الطرد⇦ '..StatusBanId
..'\n ᪣ الالعاب⇦ '..StatusGames
..'\n ᪣ امر اطردني⇦ '..Statuskickme..'*\n\n'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𓄼• ѕᴏ𝗎ʀᴄᴇ ѕᴇʟᴠᴀ •𓄹', url = 't.me/SU_SELVA'}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id,protectionGroup,'md', false, false, false, false, reply_markup)
end
if text == "الاعدادات" then    
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Text = "*\n ᪣ اعدادات الجروب ".."\n✅︙علامة صح تعني انا الامر مفتوح".."\n❌︙علامة غلط تعني انا الامر مقفول*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data = '&'},{text = 'الروابط = ', data =msg.sender.user_id..'/'.. 'Status_link'},
},
{
{text = GetSetieng(msg_chat_id).lock_spam, data = '&'},{text = 'الكلايش = ', data =msg.sender.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data = '&'},{text = 'الكيبورد = ', data =msg.sender.user_id..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(msg_chat_id).lock_vico, data = '&'},{text = 'الاغاني = ', data =msg.sender.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data = '&'},{text = 'المتحركه = ', data =msg.sender.user_id..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(msg_chat_id).lock_file, data = '&'},{text = 'الملفات = ', data =msg.sender.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data = '&'},{text = 'الدردشه = ', data =msg.sender.user_id..'/'.. 'Status_text'},
},
{
{text = GetSetieng(msg_chat_id).lock_ved, data = '&'},{text = 'الفيديو = ', data =msg.sender.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data = '&'},{text = 'الصور = ', data =msg.sender.user_id..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(msg_chat_id).lock_user, data = '&'},{text = 'المعرفات = ', data =msg.sender.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data = '&'},{text = 'التاك = ', data =msg.sender.user_id..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(msg_chat_id).lock_bots, data = '&'},{text = 'البوتات = ', data =msg.sender.user_id..'/'.. 'Status_bots'},
},
{
{text = '᪣ القائمه الثانيه ᪣', data =msg.sender.user_id..'/'.. 'NextSeting'}
},
{
{text = '᪣ اخفاء الامر ᪣', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, Text, 'md', false, false, false, false, reply_markup)
end  


if text == 'الجروب' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '【 ✅ 】' else web = '【 ❌ 】'
end
if Get_Chat.permissions.can_change_info then
info = '【 ✅ 】' else info = '【 ❌ 】'
end
if Get_Chat.permissions.can_invite_users then
invite = '【 ✅ 】' else invite = '【 ❌ 】'
end
if Get_Chat.permissions.can_pin_messages then
pin = '【 ✅ 】' else pin = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_media_messages then
media = '【 ✅ 】' else media = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_messages then
messges = '【 ✅ 】' else messges = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_other_messages then
other = '【 ✅ 】' else other = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_polls then
polls = '【 ✅ 】' else polls = '【 ❌ 】'
end
local permissions = '*\n ᪣ صلاحيات الجروب :\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘'..'\n ᪣ ارسال الويب : '..web..'\n ᪣ تغيير معلومات الجروب : '..info..'\n ᪣ اضافه مستخدمين : '..invite..'\n ᪣ تثبيت الرسائل : '..pin..'\n ᪣ ارسال الميديا : '..media..'\n ᪣ ارسال الرسائل : '..messges..'\n ᪣ اضافه البوتات : '..other..'\n ᪣ ارسال استفتاء : '..polls..'*\n\n'
local TextChat = '*\n ᪣ معلومات الجروب :\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•??⊷┉┉┉𖣘'..' \n ᪣ عدد الادمنيه : ❬ '..Info_Chats.administrator_count..' ❭\n ᪣ عدد المحظورين : ❬ '..Info_Chats.banned_count..' ❭\n ᪣ عدد الاعضاء : ❬ '..Info_Chats.member_count..' ❭\n ᪣ عدد المقيديين : ❬ '..Info_Chats.restricted_count..' ❭\n ᪣ اسم الجروب : ❬* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')* ❭*'
return LuaTele.sendText(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
if text == 'صلاحيات الجروب' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '【 ✅ 】' else web = '【 ❌ 】'
end
if Get_Chat.permissions.can_change_info then
info = '【 ✅ 】' else info = '【 ❌ 】'
end
if Get_Chat.permissions.can_invite_users then
invite = '【 ✅ 】' else invite = '【 ❌ 】'
end
if Get_Chat.permissions.can_pin_messages then
pin = '【 ✅ 】' else pin = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_media_messages then
media = '【 ✅ 】' else media = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_messages then
messges = '【 ✅ 】' else messges = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_other_messages then
other = '【 ✅ 】' else other = '【 ❌ 】'
end
if Get_Chat.permissions.can_send_polls then
polls = '【 ✅ 】' else polls = '【 ❌ 】'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = msg.sender.user_id..'/web'}, 
},
{
{text = '- تغيير معلومات الجروب : '..info, data =msg.sender.user_id..  '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data =msg.sender.user_id..  '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data =msg.sender.user_id..  '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data =msg.sender.user_id..  '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data =msg.sender.user_id..  '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data =msg.sender.user_id..  '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data =msg.sender.user_id.. '/polls'}, 
},
{
{text = '᪣ اخفاء الامر ᪣', data =msg.sender.user_id..'/'.. '/delAmr'}
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, " ᪣ الصلاحيات - ", 'md', false, false, false, false, reply_markup)
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Redis:sismember(Timo.."Timo:Developers:Groups",Message_Reply.sender.user_id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(Timo..'Timo:Originators:Group'..msg_chat_id, Message_Reply.sender.user_id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(Timo..'Timo:Managers:Group'..msg_chat_id, Message_Reply.sender.user_id) then
own = "مدير ،" else own = "" end
if Redis:sismember(Timo..'Timo:Addictive:Group'..msg_chat_id, Message_Reply.sender.user_id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(Timo..'Timo:Distinguished:Group'..msg_chat_id, Message_Reply.sender.user_id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(Message_Reply.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(Timo.."Timo:Developers:Groups",Message_Reply.sender.user_id)  then
Rink = 2
elseif Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 3
elseif Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 4
elseif Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 5
elseif Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 6
elseif Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Developers:Groups",Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Developers then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:TheBasics:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.TheBasics then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Originators then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Managers then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Addictive then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, Message_Reply.sender.user_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
if Redis:sismember(Timo.."Timo:Developers:Groups",UserId_Info.id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(Timo..'Timo:Originators:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(Timo..'Timo:Managers:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير ،" else own = "" end
if Redis:sismember(Timo..'Timo:Addictive:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(Timo..'Timo:Distinguished:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif Redis:sismember(Timo.."Timo:Developers:Groups",UserId_Info.id)  then
Rink = 2
elseif Redis:sismember(Timo.."Timo:TheBasics:Group"..msg_chat_id, UserId_Info.id) then
Rink = 3
elseif Redis:sismember(Timo.."Timo:Originators:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif Redis:sismember(Timo.."Timo:Managers:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif Redis:sismember(Timo.."Timo:Addictive:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif Redis:sismember(Timo.."Timo:Distinguished:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Developers:Groups",UserId_Info.id)
Redis:srem(Timo.."Timo:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Developers then
if Rink == 2 or Rink < 2 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:TheBasics:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.TheBasics then
if Rink == 3 or Rink < 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Originators:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Originators then
if Rink == 4 or Rink < 4 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Managers:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Managers then
if Rink == 5 or Rink < 5 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Addictive:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Addictive then
if Rink == 6 or Rink < 6 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(Timo.."Timo:Distinguished:Group"..msg_chat_id, UserId_Info.id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('اضف لقب (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('اضف لقب (.*)')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetCustomTitle = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender.user_id.."&custom_title="..CustomTitle)
local SetCustomTitle_ = JSON.decode(SetCustomTitle)
if SetCustomTitle_.result == true then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم وضع له لقب : "..CustomTitle).Reply,"md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا هناك خطا تاكد من البوت ومن الشخص","md",true)  
end 
end
if text and text:match('^اضف لقب @(%S+) (.*)$') then
local UserName = {text:match('^اضف لقب @(%S+) (.*)$')}
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName[1])
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetCustomTitle = https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
local SetCustomTitle_ = JSON.decode(SetCustomTitle)
if SetCustomTitle_.result == true then
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم وضع له لقب : "..UserName[2]).Reply,"md",true)  
else
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا هناك خطا تاكد من البوت ومن الشخص","md",true)  
end 
end 
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '᪣ تعديل الصلاحيات ᪣', data = msg.sender.user_id..'/groupNumseteng//'..Message_Reply.sender.user_id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, " ᪣ صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
var(SetAdmin)
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '᪣ تعديل الصلاحيات ᪣', data = msg.sender.user_id..'/groupNumseteng//'..UserId_Info.id}, 
},
}
}
return LuaTele.sendText(msg_chat_id, msg_id, " ᪣ صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end 
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id," ᪣ تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(UserId_Info.id," ᪣ تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == 'مسح رسائلي' then
Redis:del(Timo..'Timo:Num:Message:User'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'*᪣ تم مسح جميع رسائلك *',"md",true)  
elseif text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' then
Redis:del(Timo..'Timo:Num:Message:Edit'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'*᪣ تم مسح جميع تعديلاتك *',"md",true)  
elseif text == 'مسح جهاتي' then
Redis:del(Timo..'Timo:Num:Add:Memp'..msg.chat_id..':'..msg.sender.user_id)
LuaTele.sendText(msg_chat_id,msg_id,'*᪣ تم مسح جميع جهاتك المضافه *',"md",true)  
elseif text == 'رسائلي' then
LuaTele.sendText(msg_chat_id,msg_id,'*᪣ عدد رسائلك هنا ⇦ '..(Redis:get(Timo..'Timo:Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'سحكاتي' or text == 'تعديلاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'*᪣ عدد التعديلات هنا ⇦ '..(Redis:get(Timo..'Timo:Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'جهاتي' then
LuaTele.sendText(msg_chat_id,msg_id,'*᪣ عدد جهاتك يبشا ⇦ '..(Redis:get(Timo.."Timo:Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and msg.Addictive then
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
end
if text == 'تعين الايدي عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Timo:Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
 ᪣ ارسل الان النص
 ᪣ يمكنك اضافه :
 ᪣ `#username` » اسم المستخدم
 ᪣ `#msgs` » عدد الرسائل
 ᪣ `#photos` » عدد الصور
 ᪣ `#id` » ايدي المستخدم
 ᪣ `#auto` » نسبة التفاعل
 ᪣ `#stast` » رتبة المستخدم 
 ᪣ `#edit` » عدد السحكات
 ᪣ `#game` » عدد المجوهرات
 ᪣ `#AddMem` » عدد الجهات
 ᪣ `#Description` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Set:Id:Groups")
return LuaTele.sendText(msg_chat_id,msg_id, ' ᪣ تم ازالة كليشة الايدي العامه',"md",true)  
end

if text == 'تعين الايدي' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Timo:Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id,240,true)  
return LuaTele.sendText(msg_chat_id,msg_id,[[
 ᪣ ارسل الان النص
 ᪣ يمكنك اضافه :
 ᪣ `#username` » اسم المستخدم
 ᪣ `#msgs` » عدد الرسائل
 ᪣ `#photos` » عدد الصور
 ᪣ `#id` » ايدي المستخدم
 ᪣ `#auto` » نسبة التفاعل
 ᪣ `#stast` » رتبة المستخدم 
 ᪣ `#edit` » عدد السحكات
 ᪣ `#game` » عدد المجوهرات
 ᪣ `#AddMem` » عدد الجهات
 ᪣ `#Description` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo.."Timo:Set:Id:Group"..msg.chat_id)
return LuaTele.sendText(msg_chat_id,msg_id, ' ᪣ تم ازالة كليشة الايدي ',"md",true)  
end
if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:DevelopersQ:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مطورين ثانوين في البوت ","md",true)  
end
Redis:del(Timo.."Timo:DevelopersQ:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المطورين الثانويين*","md",true)
end
if TextMsg == 'المطورين' then
if not msg.DevelopersQ then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Developers:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مطورين في البوت ","md",true)  
end
Redis:del(Timo.."Timo:Developers:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.TheBasicsm then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد منشئين اساسيين في البوت ","md",true)  
end
Redis:del(Timo.."Timo:TheBasics:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المنشؤين الاساسيين *","md",true)
end
if TextMsg == 'المالكين' then
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(3)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:TheBasics:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مالكين في البوت ","md",true)  
end
Redis:del(Timo.."Timo:TheBasics:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المالكين *","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.TheBasics then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(4)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Originators:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد منشئين في البوت ","md",true)  
end
Redis:del(Timo.."Timo:Originators:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المنشئين *","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Originators then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(5)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Managers:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مدراء في البوت ","md",true)  
end
Redis:del(Timo.."Timo:Managers:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المدراء *","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Addictive:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد ادمنيه في البوت ","md",true)  
end
Redis:del(Timo.."Timo:Addictive:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من الادمنيه *","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:Distinguished:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مميزين في البوت ","md",true)  
end
Redis:del(Timo.."Timo:Distinguished:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المميزين *","md",true)
end
if TextMsg == 'المحظورين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد محظورين عام في البوت ","md",true)  
end
Redis:del(Timo.."Timo:BanAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if TextMsg == 'المكتومين عام' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:BanAll:Groups") 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مكتومين عام في البوت ","md",true)  
end
Redis:del(Timo.."Timo:ktmAll:Groups") 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المكتومين عام *","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد محظورين في البوت ","md",true)  
end
Redis:del(Timo.."Timo:BanGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المحظورين *","md",true)
end
if TextMsg == 'المطوردين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:MosTafa:Ahmed"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مطردين في الجروب ","md",true)  
end
Redis:del(Timo.."Timo:MosTafa:Ahmed"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المطرودين *","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' ??* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(Timo.."Timo:SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return LuaTele.sendText(msg_chat_id,msg_id," ᪣ لا يوجد مكتومين في البوت ","md",true)  
end
Redis:del(Timo.."Timo:SilentGroup:Group"..msg_chat_id) 
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..#Info_Members.."} من المكتومين *","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح {"..x.."} من المقيديين *","md",true)
end
if TextMsg == 'البوتات' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عدد البوتات الموجوده : "..#List_Members.."\n ᪣ تم طرد ( "..x.." ) بوت من الجروب *","md",true)  
end
if TextMsg == 'المطرودين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Banned", "*", 0, 200)
x = 0
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNBan_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNBan_Bots.luatele == "ok" then
x = x + 1
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عدد المطرودين في الموجوده : "..#List_Members.."\n ᪣ تم الغاء طرد عن ( "..x.." ) من الاشخاص*","md",true)  
end
if TextMsg == 'المحذوفين' then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local ban = LuaTele.getUser(v.member_id.user_id)
if ban.type.luatele == "userTypeDeleted" then
local userTypeDeleted = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
end
end
end
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ تم طرد ( "..x.." ) حساب محذوف *","md",true)  
end
end


if text == "مسح الردود" or text == "حذف ردود" or text == "مسح ردود" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(6)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(Timo.."Timo:Add:Rd:Manager:Gif"..v..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Vico"..v..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Stekrs"..v..msg_chat_id)     
Redis:del(Timo.."Timo:Add:Rd:Manager:Text"..v..msg_chat_id)   
Redis:del(Timo.."Timo:Add:Rd:Manager:Photo"..v..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:Video"..v..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:File"..v..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:video_note"..v..msg_chat_id)
Redis:del(Timo.."Timo:Add:Rd:Manager:Audio"..v..msg_chat_id)
Redis:del(Timo.."Timo:List:Manager"..msg_chat_id)
end
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم مسح قائمه الردود *","md",true)  
end
if text == "الردود" or text == "قائمه ردود" or text == "قائمه الردود" then
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هاذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:List:Manager"..msg_chat_id.."")
text = " ᪣ قائمه الردود ⇧⇩\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n"
for k,v in pairs(list) do
if Redis:get(Timo.."Timo:Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركه 🎭"
elseif Redis:get(Timo.."Timo:Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "بصمه 📢"
elseif Redis:get(Timo.."Timo:Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق 🃏"
elseif Redis:get(Timo.."Timo:Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رساله ✉"
elseif Redis:get(Timo.."Timo:Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صوره 🎇"
elseif Redis:get(Timo.."Timo:Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو 📹"
elseif Redis:get(Timo.."Timo:Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف • "
elseif Redis:get(Timo.."Timo:Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنيه 🎵"
elseif Redis:get(Timo.."Timo:Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = " ᪣ لا يوجد ردود في الجروب"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"*᪣ ارسل الان الكلمه لاضافتها في ردود *","md",true)  
end
if text == "حذف رد" then
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true2")
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ ارسل الان الكلمه لحذفها من ردود *","md",true)  
end
if text == "مسح الردود العامه" or text == "حذف الردود العامه" or text == "مسح الردود العامه" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(Timo.."Timo:Add:Rd:Sudo:Gif"..v)   
Redis:del(Timo.."Timo:Add:Rd:Sudo:vico"..v)   
Redis:del(Timo.."Timo:Add:Rd:Sudo:stekr"..v)     
Redis:del(Timo.."Timo:Add:Rd:Sudo:Text"..v)   
Redis:del(Timo.."Timo:Add:Rd:Sudo:Photo"..v)
Redis:del(Timo.."Timo:Add:Rd:Sudo:Video"..v)
Redis:del(Timo.."Timo:Add:Rd:Sudo:File"..v)
Redis:del(Timo.."Timo:Add:Rd:Sudo:Audio"..v)
Redis:del(Timo.."Timo:Add:Rd:Sudo:video_note"..v)
Redis:del(Timo.."Timo:List:Rd:Sudo")
end
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ تم حذف قائمه الردود العامه *","md",true)  
end
if text == "الردود العامه" or text == "الردود العامه" or text == "ردود عامه" then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*• هاذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(Timo.."Timo:List:Rd:Sudo")
text = "\n᪣ قائمة الردود العامه ⇧⇩\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n"
for k,v in pairs(list) do
if Redis:get(Timo.."Timo:Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif Redis:get(Timo.."Timo:Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif Redis:get(Timo.."Timo:Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif Redis:get(Timo.."Timo:Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif Redis:get(Timo.."Timo:Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif Redis:get(Timo.."Timo:Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif Redis:get(Timo.."Timo:Add:Rd:Sudo:File"..v) then
db = "ملف • "
elseif Redis:get(Timo.."Timo:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
elseif Redis:get(Timo.."Timo:Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو 🎥"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = " ᪣ لا توجد ردود عامه"
end
return LuaTele.sendText(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد عام" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n• عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Timo:Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ ارسل الان الكلمه لاضافتها في الردود العامه *","md",true)  
end
if text == "حذف رد عام" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص { '..Controller_Num(1)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(Timo..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo.."Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,"᪣ ارسل الان الكلمه لحذفها من الردود العامه","md",true)  
end
if text=="اذاعه خاص" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Timo.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ الاذاعه معطله من قبل المطور الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Timo.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[*
᪣ ارسل اذاعتك لنشرها في أعضاء خاص البوت 
᪣ للخروج من الامر ارسل𓄼الغاء𓄹
*]],"md",true)  
return false
end

if text=="اذاعه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Timo.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ الاذاعه معطله من قبل المطور الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Timo.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[*
᪣ ارسل اذاعتك لنشرها في الجروبات
᪣ للخروج من الامر ارسل𓄼الغاء𓄹
*]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Timo:Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,[[
᪣ ارسل اذاعتك لتثبيت في الجروبات
᪣ للخروج من الامر ارسل𓄼الغاء𓄹
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص𓄼 '..Controller_Num(2)..' 𓄹* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Timo.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ الاذاعه معطله من قبل المطور الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Timo.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ ارسل لي التوجيه الان*\n* ᪣ ليتم نشره في المجموعات*\n* ᪣ للخروج من الامر ارسل𓄼الغاء𓄹*","md",true)  
return false
end

if text=="اذاعه بالتوجيه خاص" then 
if not msg.Developers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص〘 '..Controller_Num(2)..' 〙* ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(Timo.."SendBcBot") then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ الاذاعه معطله من قبل المطور الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(Timo.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(Timo.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ ارسل لي التوجيه الان*\n* ᪣ ليتم نشره الى اضاء خاص البوت*\n* ᪣ للخروج من الامر ارسل〘الغاء〙*","md",true)  
return false
end
if text and text:match("(.*)(مين ضافني)(.*)") then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ انت منشئ المجموعه*","md",true) 
end
local Added_Me = Redis:get(Timo.."Who:Added:Me"..msg_chat_id..':'..msg.sender.user_id)
if Added_Me then 
UserInfo = LuaTele.getUser(Added_Me)
local Name = '['..UserInfo.first_name..'](tg://user?id='..Added_Me..')'
Text = ' ᪣ الشخص الذي قام باضافتك هو -› '..Name
return LuaTele.sendText(msg_chat_id,msg_id,Text,"md",true) 
else
return LuaTele.sendText(msg_chat_id,msg_id,"* ᪣ انت دخلت عبر الرابط محدش ضافك*","md",true) 
end
end
if text == 'بيقول اي' or text == "قال اي" or text == "يقول اي" or text == "وش يقول" then  
if tonumber(msg.reply_to_message_id) > 0 then 
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id) 
if result.content.voice_note then  
local rep = msg.id/2097152/0.5 
https.request("https://api.medooo.ml/leomedo/voiceRecognise?token="..Token.."&chat_id="..msg_chat_id.."&file_id="..result.content.voice_note.voice.remote.id.."&msg_id="..rep) 
end 
end 
end
if Redis:get(Timo.."youtube"..msg.sender.user_id..msg_chat_id) == "mp3" then
local rep = msg.id/2097152/0.5
local m = rep +1
https.request("https://api.telegram.org/bot"..Token.."/sendAnimation?chat_id="..msg_chat_id.."&animation=https://t.me/youtube7odabot/7951&reply_to_message_id="..rep)
https.request("https://api.medooo.ml/leomedo/yt?text="..URL.escape(text).."&token="..Token.."&msg_id="..rep.."&chat_id="..msg_chat_id.."&type=mp3")
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(Timo.."youtube"..msg.sender.user_id..msg_chat_id)
end
if Redis:get(Timo.."youtube"..msg.sender.user_id..msg_chat_id) == "mp4" then
local rep = msg.id/2097152/0.5
local m = rep +1
https.request("https://api.telegram.org/bot"..Token.."/sendAnimation?chat_id="..msg_chat_id.."&animation=https://t.me/youtube7odabot/7951&reply_to_message_id="..rep)
https.request("https://api.medooo.ml/leomedo/yt?text="..URL.escape(text).."&token="..Token.."&msg_id="..rep.."&chat_id="..msg_chat_id.."&type=mp4")
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(Timo.."youtube"..msg.sender.user_id..msg_chat_id)
end
if text == "مواقيت الصلاه" then
slwat = https.request("https://mahmoudm50.xyz/anubis/pray.php?city=cairo")
salawat = JSON.decode(slwat)
pray_times = salawat['results']['datetime'][1]['times']
Fajr = pray_times['Fajr']
Dhuhr = pray_times['Dhuhr']
Asr = pray_times['Asr']
Maghrib = pray_times['Maghrib']
Isha = pray_times['Isha']
return LuaTele.sendText(msg_chat_id,msg_id, "* ᪣ مواقيت الصلاه *\n*▱▰▱▰▱▰▱▰▱▰▱▰▱▰*\n".."* الفجر -› *"..Fajr.."\n* الظهر -› *"..Dhuhr.."\n* العصر -› *"..Asr.."\n* المغرب -› *"..Maghrib.."\n* العشاء -› *"..Isha.."\n*▱▰▱▰▱▰▱▰▱▰▱▰▱▰*\n* حسب التوقيت المحلي لمدينه القاهره*","md",true)
end

time = os.date("*t")
hour = time.hour
min = time.min
sec = time.sec
local_time = hour..":"..min
list_zkr = Redis:smembers(Timo.."ChekBotAdd")

if local_time then
if local_time == "0:0" and not Redis:get(Timo.."0:done") then -- الساعه 12 منتصف الليل 
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."0:done", true)
for i = 1 , 23 ,1 do 
Redis:del(Timo..i..":done")
end
end
if local_time == "1:0" and not Redis:get(Timo.."1:done") then -- الساعه 1 بعد منتصف الليل
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."1:done", true)
end
if local_time == "2:0" and not Redis:get(Timo.."2:done") then -- الساعه 2 بعد منتصف الليل
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."2:done", true)
end
if local_time == "3:0" and not Redis:get(Timo.."3:done") then -- الساعه 3 بعد منتصف الليل
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."3:done", true)
end
if local_time == "4:0" and not Redis:get(Timo.."4:done") then -- الساعه 4 بعد منتصف الليل
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."4:done", true)
end
if local_time == "5:0" and not Redis:get(Timo.."5:done") then -- الساعه 5 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."5:done", true)
end
if local_time == "6:0" and not Redis:get(Timo.."6:done") then -- الساعه 6 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."6:done", true)
end
if local_time == "7:0" and not Redis:get(Timo.."7:done") then -- الساعه 7 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."7:done", true)
end
if local_time == "8:0" and not Redis:get(Timo.."8:done") then -- الساعه 8 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."8:done", true)
end
if local_time == "9:0" and not Redis:get(Timo.."9:done") then -- الساعه 9 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."8:done", true)
end
if local_time == "10:0" and not Redis:get(Timo.."10:done") then -- الساعه 10 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."10:done", true)
end
if local_time == "11:0" and not Redis:get(Timo.."11:done") then -- الساعه 11 صباحا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."11:done", true)
end
if local_time == "12:0" and not Redis:get(Timo.."12:done") then -- الساعه 12 ظهرا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","html",true)  
end
Redis:set(Timo.."12:done", true)
end
if local_time == "13:0" and not Redis:get(Timo.."13:done") then -- الساعه 1 مسائا
for k,v in pairs(list_zkr) do
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."13:done", true)
end
if local_time == "14:0" and not Redis:get(Timo.."14:done") and not Redis:get(Timo.."14:done") then -- الساعه 2 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)
end
Redis:set(Timo.."14:done", true)
end
if local_time == "15:0" and not Redis:get(Timo.."15:done") then -- الساعه 3 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."15:done", true)
end
if local_time == "16:0" and not Redis:get(Timo.."16:done") then -- الساعه 4 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."16:done", true)
end
if local_time == "17:0" and not Redis:get(Timo.."17:done") then -- الساعه 5 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."17:done", true)
end
if local_time == "18:0" and not Redis:get(Timo.."18:done") then -- الساعه 6 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."18:done", true)
end
if local_time == "19:0" and not Redis:get(Timo.."19:done") then -- الساعه 7 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."19:done", true)
end
if local_time == "20:0" and not Redis:get(Timo.."20:done") then -- الساعه 8 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."20:done", true)
end
if local_time == "21:0" and not Redis:get(Timo.."21:done") then -- الساعه 9 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."21:done", true)
end
if local_time == "22:0" and not Redis:get(Timo.."22:done") then -- الساعه 10 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."22:done", true)
end
if local_time == "23:0" and not Redis:get(Timo.."23:done") then -- الساعه 11 مسائا
for k,v in pairs(list_zkr) do 
LuaTele.sendText(v,0, "اشهد ان لا اله الا الله وان سيدنا محمد رسول الله","md",true)  
end
Redis:set(Timo.."23:done", true)
end
end

if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ معلومات الكشف \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘"..'\n ᪣ الحظر العام : '..BanAll..'\n ᪣ الحظر : '..BanGroup..'\n ᪣ الكتم : '..SilentGroup..'\n ᪣ التقييد : '..Restricted..'*',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ معلومات الكشف \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘"..'\n ᪣ الحظر العام : '..BanAll..'\n ᪣ الحظر : '..BanGroup..'\n ᪣ الكتم : '..SilentGroup..'\n ᪣ التقييد : '..Restricted..'*',"md",true)  
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
if ban.message == "Invalid user ID" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if ban and ban.type and ban.type.luatele == "userTypeBot" then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(Timo.."Timo:BanAll:Groups",Message_Reply.sender.user_id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(Timo.."Timo:BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(Timo.."Timo:SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Addictive then
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(7)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ عذرا البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا يوجد حساب بهاذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف قناة او كروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return LuaTele.sendText(msg_chat_id,msg_id,"\n ᪣ عذرا لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(Timo.."Timo:BanAll:Groups",UserId_Info.id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(Timo.."Timo:BanGroup:Group"..msg_chat_id,UserId_Info.id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(Timo.."Timo:SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
LuaTele.sendText(msg_chat_id,msg_id,"\n* ᪣ تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end

if text == 'وضع كليشه المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(Timo..'Timo:GetTexting:DevTimo'..msg_chat_id..':'..msg.sender.user_id,true)
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ ارسل لي الكليشه الان')
end
if text == 'مسح كليشة المطور' then
if not msg.ControllerBot then 
return LuaTele.sendText(msg_chat_id,msg_id,'\n* ᪣ هاذا الامر يخص 𓄼 '..Controller_Num(1)..' 𓄹* ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SU_SELVA'}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n ᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(Timo..'Timo:Texting:DevTimo')
return LuaTele.sendText(msg_chat_id,msg_id,' ᪣ تم حذف كليشه المطور')
end
if text == "مسح الميديا" then 
if not msg.Managers then
return LuaTele.sendText(msg_chat_id,msg_id,'\n*᪣ هاذا الامر يخص⦗ '..Controller_Num(6)..' ⦘* ',"md",true)  
end
local list = Redis:smembers(Timo.."cleaner"..msg_chat_id)
if #list == 0 then 
return LuaTele.sendText(msg_chat_id,msg_id,"᪣  لا يوجد وسائط مجدوله للحذف \n ","md",true) 
end
for k,v in pairs(list) do 
LuaTele.deleteMessages(msg.chat_id,{[1]= v})
end
Redis:del(Timo.."cleaner"..msg_chat_id)
LuaTele.sendText(msg_chat_id,msg_id,"᪣  تم مسح "..#list.." من الميديا","md",true)
end

if text == "عدد الميديا" then
local list = Redis:smembers(Timo.."cleaner"..msg_chat_id)
return LuaTele.sendText(msg_chat_id,msg_id,"عدد الميديا هو "..#list.."","md",true)
end
if text and text:match("^معني (.*)$") then
local TextName = text:match("^معني (.*)$")
as = http.request('http://167.71.14.2/Mean.php?Name='..URL.escape(TextName)..'')
mn = JSON.decode(as)
k = mn.meaning
LuaTele.sendText(msg_chat_id,msg_id,k,"md",true) 
end
if text and text:match("^احسب (.*)$") then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://boyka-api.ml/Calculateage.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
end
if text == "زخرفه" or text == "زخرف"  then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*𖥔 عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'زخرفه ',  data ='/leftz@'},
},
}
}
return LuaTele.sendText(msg.chat_id,msg.id,'*\nاليك القوائم الزخرف  اضفط وزخرف*',"md",false, false, false, false, reply_markup)
end

if Redis:get(Timo.."zhrfa"..msg.sender.user_id) == "sendzh" then
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(text)..'')
zx = JSON.decode(zh)
t = "\n ᪣قائمه الزخرفه \n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."- `"..v.."` \n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
Redis:del(Timo.."zhrfa"..msg.sender.user_id) 
end

if text == 'جمالي' or text == 'نسبه جمالي' then
if not Redis:get(Timo.."Status:gamle"..msg_chat_id) then
return false
end
local ban = LuaTele.getUser(msg.sender.user_id)
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local nspp = {"1000","829","102","738","700","900","300","600","400","267","383","643","232","839","890","3728","99","98","738","100","738","729","500","102",}
local rdbhoto = nspp[math.random(#nspp)]
if photo.total_count > 0 then
data = {} 
data.inline_keyboard = {
{
{text ='نسبه جمالك يا قمر '..rdbhoto..' 🌝💙',url = "https://t.me/"..ban.username..""}, 
},
{
{text = '𓄼•ѕᴏ𝗎ʀᴄᴇ ѕᴇʟᴠᴀ•𓄹', url = "https://t.me/SU_SELVA"}
},
{
{text = 'اضف البوت لمجموعتك ✅', url = 't.me/'..UserBot..'?startgroup=new'},
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&photo=".. URL.escape(rdbhoto).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(data))
end
end
if text == 'المالك' or text == 'المنشئ' then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*᪣ عذرآ البوت ليس ادمن في  الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(Timo ..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n᪣ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local  ban = LuaTele.getUser(v.member_id.user_id)
if  ban.first_name == "" then
LuaTele.sendText(msg_chat_id,msg_id,"*᪣ اوبس , المالك حسابه محذوف *","md",true)  
return false
end 
local photo = LuaTele.getUserProfilePhotos( ban.id)
local  bain = LuaTele.getUserFullInfo(Sudo_Id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.username then
Creator = "* "..ban.first_name.."*\n"
else
Creator = "* ["..ban.first_name.."](tg://user?id="..ban.id..")*\n"
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
if photo.total_count > 0 then
local TestText = "  ❲ 𝗼𝘄𝗻𝗲𝗿 𝗴𝗿𝗼𝘂𝗽 ❳\n— — — — — — — — —\n ᪣*Owner Name* :  [".. ban.first_name.."](tg://user?id=".. ban.id..")\n᪣ *Owner Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات المالك : \n\n- [".. ban.first_name.."](tg://user?id=".. ban.id..")\n \n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
end
if text == 'المطور' or text == 'مطور' then   
local  ban = LuaTele.getUser(Sudo_Id) 
local  bain = LuaTele.getUserFullInfo(Sudo_Id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local bains = LuaTele.getUser(msg.sender.user_id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if bains.first_name then
klajq = '*['..bains.first_name..'](tg://user?id='..bains.id..')*'
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ' '..bains.username..' '
else
basgk = 'لا يوجد'
end
if ban.username then
Creator = "* "..ban.first_name.."*\n"
else
Creator = "* ["..ban.first_name.."](tg://user?id="..ban.id..")*\n"
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
local photo = LuaTele.getUserProfilePhotos(Sudo_Id)
if photo.total_count > 0 then
local TestText = "  ❲ Developers Bot ❳\n— — — — — — — — —\n ᪣*Dev Name* :  [".. ban.first_name.."](tg://user?id="..Sudo_Id..")\n᪣ *Dev Bio* : ["..Bio.." ]\n"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  ❲ Developers Timo  ❳\n— — — — — — — — —\n ᪣*Dev Name* :  [".. ban.first_name.."](tg://user?id="..Sudo_Id..")\n᪣ *Dev Bio* : [❲ "..Bio.." ❳]"
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
 
if text == 'المبرمج تيمو' or text == 'تيمو' or text == 'مبرمج السورس' or text == '𓄼 المبرمج تيمو 𓄹' then    
local UserId_Info = LuaTele.searchPublicChat("tt_t_4")
if UserId_Info.id then
local  ban = LuaTele.getUser(UserId_Info.id)
local  bain = LuaTele.getUserFullInfo(UserId_Info.id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Timo\n"
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "𓄼•ᴅᴇᴠ•ᴛɪᴍᴏ•𓄹\n— — — — — — — — —\n ᪣*Dev Name* :  [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n᪣ *Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '𓄼•ᴅᴇᴠ•ᴛɪᴍᴏ•𓄹', url = "https://t.me/tt_t_4"}
},
{
{text = '𓄼•ɢʀᴏ𝗎ᴘ•𓄹', url = "https://t.me/br_selva"},{text = '𓄼•ᴄʜᴀɴɴᴇʟ•𓄹', url = "https://t.me/SU_SELVA"}
},
{
{text = '𓄼•ʙᴏᴛ ѕᴇʟᴠᴀ•𓄹',url="t.me/Timo8Bot"}
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = " 𓄼•ᴅᴇᴠ•ᴛɪᴍᴏ•𓄹\n— — — — — — — — —\n ᪣*Dev Name* :  [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n᪣ *Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '𓄼•ᴅᴇᴠ•ᴛɪᴍᴏ•𓄹', url = "https://t.me/tt_t_4"}
},
{
{text = '𓄼•ɢʀᴏ𝗎ᴘ•𓄹', url = "https://t.me/br_selva"},{text = '𓄼•ᴄʜᴀɴɴᴇʟ•𓄹', url = "https://t.me/SU_SELVA"}
},
{
{text = '𓄼•ʙᴏᴛ ѕᴇʟᴠᴀ•𓄹',url="t.me/Timo8Bot"}
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == 'المبرمج سيزر' or text == 'سيزر' or text == 'مطور السورس' or text == '𓄼 المبرمج سيزر 𓄹' then    
local UserId_Info = LuaTele.searchPublicChat("ttccss")
if UserId_Info.id then
local  ban = LuaTele.getUser(UserId_Info.id)
local  bain = LuaTele.getUserFullInfo(UserId_Info.id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Timo\n"
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "𓄼•ᴅᴇᴠ•ѕᴇᴢʀ•𓄹\n— — — — — — — — —\n ᪣*Dev Name* :  [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n᪣ *Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '𓄼•ᴅᴇᴠ•ѕᴇᴢʀ•𓄹', url = "https://t.me/ttccss"}
},
{
{text = '𓄼•ɢʀᴏ𝗎ᴘ•𓄹', url = "https://t.me/br_selva"},{text = '𓄼•ᴄʜᴀɴɴᴇʟ•𓄹', url = "https://t.me/SU_SELVA"}
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = " 𓄼•ᴅᴇᴠ•ᴛɪᴍᴏ•𓄹\n— — — — — — — — —\n ᪣*Dev Name* :  [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n᪣ *Dev Bio* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '𓄼•ᴅᴇᴠ•ѕᴇᴢʀ•𓄹', url = "https://t.me/ttccss"}
},
{
{text = '𓄼•ɢʀᴏ𝗎ᴘ•𓄹', url = "https://t.me/br_selva"},{text = '𓄼•ᴄʜᴀɴɴᴇʟ•𓄹', url = "https://t.me/SU_SELVA"}
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end

if text == 'المطور' or text == 'مطور' or text == 'مطور' then   
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local bains = LuaTele.getUser(msg.sender.user_id)
if bains.first_name then
klajq = '*['..bains.first_name..'](tg://user?id='..bains.id..')*'
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ' '..bains.username..' '
else
basgk = 'لا يوجد'
end
local czczh = '*'..bains.first_name..'*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = czczh, url = "https://t.me/"..bains.username..""},
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n᪣ مرحباً عزيزي المطور \nشخص ما يحتاج الي مساعده\n𖣘┉┉┉⊶𓄼•𝐒𝐄𝐋𝐕𝐀•𓄹⊷┉┉┉𖣘\n᪣ اسمه :- '..klajq..' \n᪣ ايديه :-  : '..msg.sender.user_id..'\n᪣ - معرفة '..basgk..' \n*',"md",false, false, false, false, reply_markup)
end
if text == 'المبرمج تيمو' 