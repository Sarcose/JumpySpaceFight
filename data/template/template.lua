--[[
    Okay, we have swapped the term "Prototype" and "Template." I am most familiar with 3.5 D&D's "templates" which are stackable.
    In the intended implementation of this class, I want the following workflow:

    1. Instantiate an Entity
    2. Apply basic Entity systems, inherited
    3. Apply templates, one by one, in deterministic order
        3a. Templates overwrite when an overlap is found
        3b. Templates may occasionally reduce basic function or remove other template functions
        
    the gcoreType types are thus, all "Prototypes" in that they are the starting point for the instance.
    Instantiations from *THIS* class are thus all "Templates", NOT prototypes

    To reflect the Prototype naming scheme we put "Prototype" as a suffix for all instance names of said prototypes.
    
]]



local defaults = {
    type = "Template",
    name = "TemplatePrototype",
}
--an extremely simple primitive, this will use layered implementation to apply its methods
return function(context)
    local Template = context.class:extend(defaults)
        
    --templates are applied using Class's "implement" function
    --therefore any systems 

    Template.systems = {}   --indiced list of system paths to apply to the creature
    Template.applications = {} --indiced list of *functions* to run on the creature. This is how we make changes or remove major elements.


    return Template
end