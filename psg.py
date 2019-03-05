#!/usr/bin/python3
import subprocess
import itertools

device_sn="8BDAX00AB6"

def run_cmd(cmd):
	return subprocess.getoutput("/usr/local/google/home/oceanchen/platform-tools/adb -s " + device_sn + " shell \"" + cmd + "\"")

def click(position):
	cmd = "input touchscreen tap " + str(position[0]) + " " + str(position[1])
	run_cmd(cmd)

def get_color(position):
	cmd = "screencap -x " + str(position[0]) + " -y " + str(position[1])
	out = run_cmd(cmd)
	return int(out, 16)

def color_is(position, color_in_script):
 	return get_color(position) == color_in_script

def color_match_click(position, color_in_script):
	for x in range(1, 5):
		if color_is(position, color_in_script):
			click(position)

def is_main_page():
	return color_is((310, 50), 0xFFADCDDF)

def is_moval_page():
	if color_is((879, 938), 0xFF6487CE):
		print("Hit furniture double")
		return True

def is_furniture_page():
	if color_is((907, 777), 0xFF000040):
		print("Hit furniture")
		return True

def is_craftsman_page():
	if color_is((816, 918), 0xFF32B6FF):
		print("Meet craftsman")
		return True

def is_customer_page():
	if color_is((903, 391), 0xFFFFFFFF):
		print("Meet customer")
		return True

def is_dog_page():
	if color_is((1128, 669), 0xFF2765B8):
		print("Meet dog")
		return True

def is_self_page():
	if color_is((530, 800), 0xFF797E8C):
		print("Meet self")
		return True

def increase_price():
 	p=(1792, 531)
 	color_match_click(p, 0xFFC7E1EA)

def push_wanted_item():
	p=(1344, 398)
	color_match_click(p, 0xFF52076F)

def service_customer():
	p=(1820, 846)
	push_wanted_item()
	increase_price()
	if color_is(p, 0xFF4699B9):
		print("refuse general customer")
		click((1791, 689))
	elif color_is(p, 0xFF999999):
		print("refuse special customer")
		click((1791, 689))
	color_match_click(p, 0xFF5EAA3D)

def back_to_main_page():
	for x in range(1, 10):
		if is_moval_page():
			click((879, 938))
		elif is_furniture_page():
			click((2025, 1042))
		elif is_customer_page():
			service_customer()
		elif is_craftsman_page():
			click((1728, 198))
		elif is_dog_page():
			click((2109, 60))
		elif is_self_page():
			click((1728, 198))
		else:
			print("unknown page")
		if is_main_page():
			return

def sell_equip():
	p = [920, 580]
	a = [0, 0]
	for y in range(0, 6):
		for x in range(0, 8):
			a[0] = p[0] + 32 * x
			a[1] = p[1] + 20 * x
			print(a)
			click(a)
			if is_main_page():
				print("In main page clicked " + str(a))
			else:
				back_to_main_page()
				if not is_main_page():
					return
		p[0] += 29
		p[1] -= 17

def main():
	sell_equip()

if __name__ == '__main__':
	main()
