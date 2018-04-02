## function to convert rgb to hex and vice versa
## author: D.Kisler <admin@dkisler.de>

def rgb2hex(r, g, b):
  def clamp(x):
  return max(0, min(x, 255))
return "#{0:02x}{1:02x}{2:02x}".format(clamp(r), clamp(g), clamp(b))

def hex2rgb(hexcode):
  return list(int(hexcode.replace('#', '')[i:i+2], 16) for i in (0, 2 ,4))