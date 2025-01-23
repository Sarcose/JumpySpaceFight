local engine = {}
engine.stateCategory = "prototypes"
local defaultState = "design_playground"     --current testing state. OR: the "Open" state when the game is playable.
engine.prototypes = {
    --[[draw = require "state.prototypes.draw",
    ui = require "state.prototypes.ui",
    control = require "state.prototypes.control",
    entity = require "state.prototypes.entity",
    topdown = require "state.prototypes.topdown",
    slick_topdown = require "state.prototypes.slick_topdown",
    slick_gravity = require "state.prototypes.slick_gravity",
    composite_entities = require "state.prototypes.composite_entities",
    stress_test_1 = require "state.prototypes.stress_test_1",
    design_playground = require "state.prototypes.design_playground",
    _tableName = "engine.prototypes"--]]
}
engine.states = {

}


function engine:load(state, save)
    if not state then state = defaultState end
    --self:changeState(state)     --TODO: Save file
end

function engine:update(dt)
    --local change = self.state:update(dt)
    if change then
        self:changeState(change)
    end
end

function engine:changeState(change)
    --if self.state then self.state:unload() end
    self.currentState = change
    self.state = self[self.stateCategory][self.currentState]
    self.state:load()
end

function engine:draw()
    --self.state:draw()
end

return engine