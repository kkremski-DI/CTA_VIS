
import sys
from urllib2 import Request, urlopen, URLError
import time
from xml.etree import cElementTree as ET
request = Request('http://www.ctabustracker.com/bustime/api/v1/getvehicles?key=iwAameW6cVPbv4PTdka8KEu3b&rt=66')
response = urlopen(request)
out = response.read()
#print(out)
t = 0
#output = sys.stdout
f = open('loctime2.csv', 'w')
#sys.stdout = f

while t<300:
	t = t+1
	request = Request('http://www.ctabustracker.com/bustime/api/v1/getvehicles?key=iwAameW6cVPbv4PTdka8KEu3b&vid=4125')
	try:
		response = urlopen(request)
		out = response.read()
		root = ET.fromstring(out)
		values = (root[0][2].text+','+ root[0][3].text+ ','+ root[0][1].text+ '\r\n')
		s= str(values)
		f.write(s)	
		#print root[0][2].text,',',root[0][3].text, ',',root[0][1].text,'\n'
		#print(root[0][3].text)
		
	except URLError as e:
  	  	print('Error:', e)
	time.sleep(5)	
