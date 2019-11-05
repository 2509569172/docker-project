def filter(event)
	type=event.get("type")
	sipmsg=event.get("sipmsg").upcase

	if type=="RECEIVE"
		if sipmsg.match(/^INVITE/)
			event.set("flow","02")
		elsif sipmsg.match(/^SIP\/2.0 100 TRYING/)
			event.set("flow","03")
		elsif sipmsg.match(/^SIP\/2.0 180 RINGING/)
			event.set("flow","04")
		elsif sipmsg.match(/^REGISTER/)
			event.set("flow","00")
		elsif sipmsg.match(/^ACK/)
			event.set("flow","06")
		elsif sipmsg.match(/^INFO/)
			event.set("flow","17")
		elsif sipmsg.match(/^BYE/)
			event.set("flow","07")
		else
			event.set("flow","18")
		end
	else
		if sipmsg.match(/^SIP\/2.0 200 OK/)
			start=sipmsg.index("CSEQ:")
			endd=sipmsg.index("\r\n",start+5)
			str=sipmsg[start+5,endd]
			if str.include?"REGISTER"
				event.set("flow","01")
			elsif str.include?"INVITE"
				event.set("flow","05")
			elsif str.include?"BYE"
				event.set("flow","08")
			else
				event.ste("flow","18")
			end
		end
	end

	return [event]
end
