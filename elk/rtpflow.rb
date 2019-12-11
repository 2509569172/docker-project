def filter(event)
	serverport=event.get("serverport")
	to=event.get("toSocket")
	from=event.get("from").upcase
	
	if from.match(/^SIP:/)
		if serverport==5006
			if to=="server"
				event.set("flow","11")
			else
				event.set("flow","12")
			end
		end
		
		if serverport==5008
			if to=="server"
				event.set("flow","13")
			else
				event.set("flow","14")
			end
		end
		
	else
		if serverport==5006
			if to=="server"
				event.set("flow","15")
			else
				event.set("flow","16")
			end
		end
		
		if serverport==5008
			if to=="server"
				event.set("flow","17")
			else
				event.set("flow","18")
			end
		end		
	end
	
	return [event]
end
