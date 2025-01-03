---
date: '2007-12-09'
layout: post
permalink: /blog/2007/12/09/just-some-idle-anti-spam-thoughts/
title: Just Some Idle Anti-Spam Thoughts
---
Earlier this year, I came off a five year stint in the anti-spam industry. As such, I tend to try to keep up on the latest in that world. Tonight, I was talking with an acquaintance of mine and the topic of spam came up. I was telling him about the [Storm Worm](https://en.wikipedia.org/wiki/Storm_Worm) and the relatively new wave of stock pump-and-dump spams with professional-looking PDF attachments as payload. He's an options trader at [SIG](https://sig.com/) and he had a different take on that kind of spam: he told me he had looked at getting into that market! Not spam, mind you, but rather shorting the stocks that are featured in these pump-and-dump spams. Obviously, this is how the originating spammers themselves make money but I never figured a legitimate outfit to get involved with stuff like that (they decided not to, he said). Now, I don't know if this is true, but he also told me that there are entire hedge funds that just watch the mail streams and look for these pump-and-dumps to make short moves on. I found this fascinating for some reason.

This was on my mind as I was driving home and I wandered a bit in my thinking. I started to think about the work I had done and how I really enjoyed the anti-spam challenge. It seems to me that the fundamental challenges in anti-spam are twofold:

* Your opponents are highly motivated because the profit margins are so high (spam is very cheap to create/send)
* Commercial filters are bound to increase their effectiveness even in the face of every higher volumes of spam every year

I started thinking harder about that last part and I was thinking, "hmmm... what else has a super low signal:noise ratio?" Then I thought of astronomical observation data. I was talking with someone at Amazon about that very thing and he was telling me that astronomical observation data tends to be huge (~2GB second, raw) and that it contained almost no signal. I wonder what techniques they are using to sift out the meat there and whether or not any of them are applicable to spam filtration. Anybody looked into the parity between these two before?

Finally, I got to thinking about some of the techniques that are in use today and I hit upon an interesting thought I'd never come across before. Distributed reputation services are pretty much the de facto standard these days for all commercial vendors. Every vendor has a different pretentious name for these things but, basically, they constantly update centralized databases of sender reputation in near real-time based on the information about emails flowing into their edge systems. These edge systems can be desktop spam filters (e.g. [Cloudmark](https://www.cloudmark.com/en)) or big, honkin' border MTAs like the [SMS 8300](https://www.commoncriteriaportal.org/files/epfiles/sms8300-tar-e.pdf) or something in between.

I was thinking, "its easy to do that on one MTA". Just have the MTA keep a database of reputation information and update it incrementally as new mails flow in and the filter renders a verdict. Hell, if you log your filter verdicts, you could just run through that every hour or so if you wanted it to be not so good.

However, then I thought, "hmmm... I wonder what the marginal value of a *distributed* reputation service is?" Meaning: what's the difference in value between a purely on-box reputation database versus one that takes feeds (albeit updated more slowly) from a network of border MTAs? Given that all of these services (with the exception of [Vipul's Razor](https://www.sciencedirect.com/science/article/abs/pii/S1353485807700831)) are commercial I would have expected to see a showdown in some magazine by now. I guess since they are just pieces of a larger product they are not usually featured on their own (except [SenderBase](https://web.archive.org/web/20080830040748/http://www.dumpnload.com/2007/02/15/senderbaseorg-sucks/), which IronPort can't shut up about). 

Still, I think that'd be an interesting analysis to really profile the ROI and particulars on a distributed reputation service like that versus purely local reputation information. One could find the theoretical optimal number of nodes in said network and find out the scaling model of a service like that along a bunch of different metrics, etc. You could even throw some agent-based modeling at it and simulate Internet conditions to see more pros/cons of each. Has anyone else ever heard of an analysis like this?

Then, I was thinking, "dood its late..."
