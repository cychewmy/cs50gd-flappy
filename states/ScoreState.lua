--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- add medal award
    default_medal = "crystal_grey.png"
    if (self.score > 0) then
        medalImage1 = love.graphics.newImage("crystal_bronze.png")
    else
        medalImage1 = love.graphics.newImage(default_medal)
    end
    love.graphics.draw(medalImage1, (VIRTUAL_WIDTH / 2) - 16 - (32 + 32), 120)

    if (self.score >= 3) then
        medalImage2 = love.graphics.newImage("crystal_silver.png")
    else
        medalImage2 = love.graphics.newImage(default_medal)
    end
    love.graphics.draw(medalImage2, (VIRTUAL_WIDTH / 2) - 16 , 120)

    if (self.score >= 5) then
        medalImage3 = love.graphics.newImage("crystal_gold.png")
    else
        medalImage3 = love.graphics.newImage(default_medal) 
    end
    love.graphics.draw(medalImage3, (VIRTUAL_WIDTH / 2) + (16 + 32), 120)

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end