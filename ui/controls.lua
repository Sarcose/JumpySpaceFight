--default controller
local c = {}

function c:load()   --in the future, we will load from a settings storage
    local controller = baton.new {
        controls = { 
            left = {'key:left', 'axis:leftx-', 'button:dpleft'},
            right = {'key:right', 'axis:leftx+', 'button:dpright'},
            up = {'key:up', 'axis:lefty-', 'button:dpup'},
            down = {'key:down', 'axis:lefty+', 'button:dpdown'},
            rightface = {'key:d','key:lctrl','button:b','mouse:1'},     --action
            bottomface = {'key:s','space','key:escape','button:a','mouse:2'},   --jump
            leftface = {'key:a','key:-','button:x','mouse:4'},          --subslot1
            topface = {'key:w','key:=','button:y','mouse:5'},           --subslot2
            pause = {'key:return', 'button:start'},
            select = {'key:rctrl', 'button:back'},
            lbutton = {'key:lshift', 'button:leftshoulder'},
            rbutton = {'key:rshift', 'button:rightshoulder'},
            prev = {'key:z','key:escape','button:b','mouse:2'},
            printglobal = {'key:p'},
            debug = {'key:`'},
            shift = {'key:lshift'},
            rb = {'key:rshift','key:lshift'},
            alt = {'key:ralt','key:lalt'},
            lb = {'key:ralt','key:lalt'},   --need to find rb and lb in button codes
            reset = {'key:r'},
            u = {'key:u'},
            i = {'key:i'},
            j = {'key:j'},
            i = {'key:i'},
            k = {'key:k'},
            l = {'key:l'},
            y = {'key:y'},
            h = {'key:h'},
            ctrl = {'lctrl'},
            mb_left = {'mouse:1'},
            mb_middle = {'mouse:3'},
            mb_right = {'mouse:2'},
            mb_backward = {'mouse:4'},
            mb_forward = {'mouse:5'}
        },
        pairs = {	
            move = {'left', 'right', 'up', 'down'}
        },
        joystick = love.joystick.getJoysticks()[1],
        deadzone = .33,
    }
    controller.wheel = {x=0,y=0}
    return controller
end

return c