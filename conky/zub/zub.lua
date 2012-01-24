--[[
observer.lua by mrsnail.
	Based on the superb script, Ring Meters by londonali1010. Big thanks!
	
What i did:
	Added rotating motion for rings.
	Added bar drawing function.

Original notes:
/This script draws percentage meters as rings. It is fully customisable; all options are described in the script.
/
/IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement near the end of the script uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num > 5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num > 3; conversely if you update Conky every 0.5s, you should use update_num > 10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.
/


To call this script in Conky, use the following (assuming that you save this script to ~/scripts/observer.lua):
	lua_load ~/scripts/observer.lua
	lua_draw_hook_pre ring_stats
]]
-- Settings table for rings:
settings_table = {
	{
		name='time',		--Conky var name.
		arg='%M.%S',		--Args for conky.
		max=60,			--Max return value from conky.
		bg_colour=0xFFFFFF,	--Background color of the ring.
		bg_alpha=0.1,		--Alpha of the background.
		fg_colour=0xFF0000,	--Foreground color of the ring.
		fg_alpha=0.3,		--Alpha of the foreground.
		x=110, y=110,		--Position of the ring. (Center)
		radius=55,		--Radius of the ring.
		thickness=20,		--Thickness of the ring.
		start_angle=0,		--Starting angle.
		end_angle=320,		--End angle.
		motion=0.5		--Rotating motion. (Any value > 0 makes the ring rotate CW, while values < 0 makes the ring rotate CCW. For still rings use 0.)
	},
	{
		name='time',
		arg='%S',
		max=60,
		bg_colour=0xFFFFFF,
		bg_alpha=0.1,
		fg_colour=0xF4753E,
		fg_alpha=0.6,
		x=110, y=110,
		radius=58,
		thickness=4,
		start_angle=220,
		end_angle=420,
		motion=-2
	},
	{
		name='time',
		arg='%H',
		max=24,
		bg_colour=0xFFFFFF,
		bg_alpha=0.1,
		fg_colour=0xF47bcE,
		fg_alpha=0.6,
		x=110, y=110,
		radius=40,
		thickness=8,
		start_angle=220,
		end_angle=270,
		motion=-0.5
	},
	{
		name='cpu',
		arg='cpu1',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0,
		fg_colour=0xF4753E,
		fg_alpha=0.8,
		x=110, y=110,
		radius=70,
		thickness=5,
		start_angle=0,
		end_angle=60,
		motion=0
	},
	{
		name='cpu',
		arg='cpu2',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0,
		fg_colour=0xF4753E,
		fg_alpha=0.8,
		x=110, y=110,
		radius=80,
		thickness=5,
		start_angle=0,
		end_angle=60,
		motion=0
	},
	{
		name='battery_percent',
		arg='BAT0',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.15,
		fg_colour=0x6D4B9C,
		fg_alpha=0.5,
		x=110, y=110,
		radius=72,
		thickness=11,
		start_angle=180,
		end_angle=290,
		motion=0
	},
	{
		name='fs_free_perc',
		arg='/home/mem',
		max=100,
		bg_colour=0xB4DC57,
		bg_alpha=0.15,
		fg_colour=0x218021,
		fg_alpha=0.7,
		x=110, y=110,
		radius=85,
		thickness=10,
		start_angle=190,
		end_angle=280,
		motion=0
	},
	{
		name='acpitemp',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.15,
		fg_colour=0xF4753E,
		fg_alpha=0.4,
		x=110, y=110,
		radius=98,
		thickness=7.5,
		start_angle=-120,
		end_angle=-15,
		motion=0
	},
	{
		name='mixer',
		arg='',
		max=100,
		bg_colour=0xffffff,
		bg_alpha=0.15,
		fg_colour=0xF4753E,
		fg_alpha=0.3,
		x=248, y=88,
		radius=20,
		thickness=10,
		start_angle=0,
		end_angle=360,
		motion=0
	},
}

-- Settings table for bars.
settings_bars = {
	{
		name='diskio_read',		--Conky var.
		arg='sda',			--Conky arg.
		max=5000000,			--Max return value. (Here set for a value that makes the diskio bar jumpy. If the ret. value is greater than max, the bar will show 100%.)
		bg_colour=0xF4753E,		--Bar bg.
		bg_alpha=0.4,			--Bg alpha.
		fg_colour=0xF4CA3E,		--Bar fg.
		fg_alpha=0.8,			--Fg alpha.
		x=400, y=90,			--Starting point of the bar. (In pixels)
		length=100,			--Length of the bar. (In pixels.)
		thickness=6,			--Thickness of the bar.
		angle=-math.pi/4		--Angle of the bar. (In radians from horizontal. A negative angle rotates the bar CCW.)
	},
	{
		name='diskio_write',
		arg='sda',
		max=5000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xFF453E,
		fg_alpha=0.8,
		x=390, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
	{
		name='diskio_read',
		arg='sdb',
		max=5000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xF4CA3E,
		fg_alpha=0.8,
		x=370, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
	{
		name='diskio_write',
		arg='sdb',
		max=5000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xFF453E,
		fg_alpha=0.8,
		x=360, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
	{
		name='diskio_read',
		arg='sdc',
		max=1000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xF4CA3E,
		fg_alpha=0.8,
		x=340, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
	{
		name='diskio_write',
		arg='sdc',
		max=1000000,
		bg_colour=0xF4753E,
		bg_alpha=0.4,
		fg_colour=0xFF453E,
		fg_alpha=0.8,
		x=330, y=90,
		length=100,
		thickness=6,
		angle=-math.pi/4
	},
}


require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height
	
	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	-- Draw background ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	
	-- Draw indicator ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)		
end

function draw_bar(cr,t,pt)
	local w,h=conky_window.width,conky_window.height
	
	local xc,yc,bar_a,bar_w,bar_len=pt['x'],pt['y'],pt['angle'],pt['thickness'],pt['length']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local t_len=t*bar_len
	local enx,eny=xc+bar_len*math.cos(bar_a),yc+bar_len*math.sin(bar_a)
	local enxi,enyi=xc+t_len*math.cos(bar_a),yc+t_len*math.sin(bar_a)


	-- Draw background bar

	cairo_move_to(cr, xc, yc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,bar_w)
	cairo_line_to(cr, enx, eny)
	cairo_stroke(cr)

	-- Draw indicator bar

	cairo_move_to(cr, xc, yc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_line_to(cr, enxi, enyi)
	cairo_stroke(cr)
	
end

function conky_ring_stats()

	-- The somewhat modified setup_rings function.
	local function setup_rings(cr,pt)
		local str=''
		local value=0
		
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		
		value=tonumber(str)
		if value == nil then value = 0 end
		pct=value/pt['max']
	
		--This code does the rotation. Pretty simple addition.
		pt['start_angle'],pt['end_angle']=pt['start_angle']+pt['motion'],pt['end_angle']+pt['motion']
		
		--This keeps the values around 0...360
		if pt['end_angle']<0 then --for CCW rotation,
			pt['start_angle'],pt['end_angle']=pt['start_angle']+360,pt['end_angle']+360
			end
			
		if pt['end_angle']>360 then --and for CW rotation.
			pt['start_angle'],pt['end_angle']=pt['start_angle']-360,pt['end_angle']-360
			end
	
		draw_ring(cr,pct,pt)
	end
	
	-- Pretty mutch the same as the original setup_rings(cr,pt), except it calls my draw_bar function.
	local function setup_bars(cr,pt)
		local str=''
		local value=0
		
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		
		value=tonumber(str)
		if value == nil then value = 0 end
		if value>pt['max'] then pct=1 else pct=value/pt['max'] end
	
		draw_bar(cr,pct,pt)
	end

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	
	local cr=cairo_create(cs)	
	
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	
	if update_num>5 then
		
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
		
		for i in pairs(settings_bars) do
			setup_bars(cr,settings_bars[i])
		end

	end


	--[[
		Here's some extra stuff for my conky setup.
		Get rid of it, if you don't want it. I'ts not the part of the code.
		I'm just lazy to create a second lua file.
	]]
	-- Draw horz.line.
	local lic,lia = 0xf4753e, 1
	cairo_set_line_width(cr, 1)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(lic,lia))
	cairo_move_to(cr, 100, 120)
	cairo_line_to(cr, 520, 120)
	cairo_stroke(cr)
	
	-- Draw nodename.
	local nname=conky_parse('${nodename}')
	cairo_select_font_face(cr, 'Alpha Sentry', CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
	cairo_set_font_size(cr, 24)
	cairo_move_to(cr, 100, 115)
	cairo_show_text(cr, nname)
	
	-- Draw eth0, wlan0 address verticaly.
	cairo_select_font_face(cr, 'fixed', CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
	cairo_set_font_size(cr, 8)
	cairo_rotate(cr,math.pi/2)
	cairo_move_to(cr, 160, -262)
	cairo_show_text(cr, conky_parse('${addr eth0}'))
	cairo_move_to(cr, 160, -282)
	cairo_show_text(cr, conky_parse('${addr wlan0}'))
	
	-- Draw time.
	cairo_select_font_face(cr, 'CAPTURE IT', CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
	local hour,min = conky_parse('${time %H}'), conky_parse('${time %M}')
	cairo_rotate(cr,-math.pi/2)
	cairo_move_to(cr, 430, 115)
	cairo_set_font_size(cr, 38)
	cairo_show_text(cr, hour)
	cairo_set_font_size(cr, 28)
	cairo_show_text(cr, ' '..min)
	
	--[[
		End of extra stuff.
	
	]]
end