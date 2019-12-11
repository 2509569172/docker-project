def filter(event)
	type=event.get("type")
	sipmsg=event.get("sipmsg").upcase

	if type=="RECEIVE"
		if sipmsg.match(/^INVITE/)
			event.set("flow","01")
		elsif sipmsg.match(/^SIP\/2.0 100 TRYING/)
			event.set("flow","03")
		elsif sipmsg.match(/^SIP\/2.0 180 RINGING/)
			event.set("flow","05")
		elsif sipmsg.match(/^REGISTER/)
			event.set("flow","43")
		elsif sipmsg.match(/^ACK/)
			event.set("flow","09")
		elsif sipmsg.match(/^INFO/)
			event.set("flow","33")
		elsif sipmsg.match(/^BYE/)
			event.set("flow","19")
		elsif sipmsg.match(/^SIP\/2.0 200 OK/)
			start1=sipmsg.index("CSEQ:")
			end1=sipmsg.index("\\R\\N",start1+5)
			str1=sipmsg[start1+5,end1]
			if str1.include?"INVITE"
				event.set("flow","07")
			elsif str1.include?"BYE"
				event.set("flow","21")
			end
		elsif sipmsg.match(/^SIP\/2.0 4/) or sipmsg.match(/^SIP\/2.0 5/) or sipmsg.match(/^SIP\/2.0 6/)
			start2=sipmsg.index("CSEQ:")
			end2=sipmsg.index("\\R\\N",start2+5)
			str2 = sipmsg[start2+5,end2]
			if str2.include?"INVITE"
				event.set("flow","07")
			elsif str2.include?"BYE"
				event.set("flow","21")
			end
		else
			event.set("flow","55")
		end
	else
		if sipmsg.match(/^SIP\/2.0 200 OK/)
			start=sipmsg.index("CSEQ:")
			endd=sipmsg.index("\\R\\N",start+5)
			str=sipmsg[start+5,endd]
			if str.include?"REGISTER"
				event.set("flow","44")
			elsif str.include?"INVITE"
				event.set("flow","08")
			elsif str.include?"BYE"
				event.set("flow","22")
			else
				event.set("flow","56")
			end
		elsif sipmsg.match(/^INVITE/)
			event.set("flow","02")
		elsif sipmsg.match(/^SIP\/2.0 100 TRYING/)
			event.set("flow","04")
		elsif sipmsg.match(/^SIP\/2.0 180 RINGING/)
			event.set("flow","06")
		elsif sipmsg.match(/^ACK/)
			event.set("flow","10")
		elsif sipmsg.match(/^INFO/)
			event.set("flow","34")
		elsif sipmsg.match(/^BYE/)
			event.set("flow","20")
		elsif sipmsg.match(/^SIP\/2.0 4/) or sipmsg.match(/^SIP\/2.0 5/) or sipmsg.match(/^SIP\/2.0 6/)
			start3=sipmsg.index("CSEQ:")
			end3=sipmsg.index("\\R\\N",start3+5)
			str3=sipmsg[start3+5,end3]
			if str3.include?"INVITE"
				event.set("flow","08")
			elsif str3.include?"BYE"
				event.set("flow","22")
			end
		else
			event.set("flow","56")
		end
	end

	return [event]
end
