
function prepare(font)
	disp:setFont(font)
	disp:setFontRefHeightExtendedText()
	disp:setDefaultForegroundColor()
	disp:setFontPosTop()
end

function draw(font, height, text )
	prepare(font)
	disp:firstPage()
	repeat
		for i, v in pairs(text) do
			disp:drawStr(0, (i - 1) * height, v)
		end
	until disp:nextPage() == false
end

local function avarage_read(count)
	sum = 0
	for i = 1, count do
		sum = sum + hx711.read(0)
	end
	
	return sum / count
end

local hx711_sck  = 2 -- GPIO05
local hx711_data = 1 -- GPIO04
local scl = 5 -- GPIO14
local sda = 6 -- GPIO12
local sla = 0x3c

-- init hx711
hx711.init(hx711_sck, hx711_data)

-- init display
i2c.setup(0, sda, scl, i2c.SLOW)
disp = u8g.ssd1306_128x64_i2c(sla)

--[[
--font_10x20
--font_10x20r
--font_6x10
--font_fur20
--font_fur30
--font_osr35r
--font_chikita
--]]

draw(u8g.font_10x20, 14, {"    ", "calibrating...", " "})
offset = avarage_read(10)
print(string.format("offset is %d", offset))
draw(u8g.font_10x20, 14, {"offset:", offset})

--tmr.register(0, 500, tmr.ALARM_AUTO, function() print(avarage_read(5) - offset) end)
--tmr.start(0)
