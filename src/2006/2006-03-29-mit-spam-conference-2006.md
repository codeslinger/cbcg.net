---
date: '2006-03-29'
layout: post
permalink: /blog/2006/03/29/mit-spam-conference-2006/
title: MIT Spam Conference 2006
---
_UPDATE: The [papers and slides](https://www.spamconference.org/SC2006.iso) are now available for download._

Overview
--------

Just got done with the MIT Spam Conference 2006 and let me tell you, it was much better than last year. This might have been the best one yet. Most of the talks were pretty good and there was a definitive blunting of the [Bayes](https://en.wikipedia.org/wiki/Bayes%27_theorem) daisho they had been wielding in previous years. This year, the conference was held in March, so it wasn't anywhere near as cold as it was in previous years (when it was held in early January). And the next one will be around the same time, so that's even better!

[CipherTrust](https://en.wikipedia.org/wiki/CipherTrust) sponsored the meetup the night before and it was a fun time. I talked to a bunch of people that night, including [Jon Zdziarski](https://www.zdziarski.com/blog/) and Matt Sergeant. It was held at the Cambridge Brewing Company, which cabbies apparently have a tough time finding, but I made it there alright. We ended up going there again for dinner the second night and they had some good food.

The conference itself was very punctual this year. In past years, there had been problems with that, but [Bill](https://www.networkworld.com/article/828116/lan-wan-the-antispam-man.html) ran a pretty tight ship this year. There weren't a lot of people there at all (it was packed last year) and that's a shame. They missed out. I had some more pictures, but the RAZR doesn't take very good pictures in low light, so I'm only putting up the ones that came out.

![](/a/032806_16282.jpg)

Presentations
--------------

First, Tobias Eggendorfer gave a high-level overview of HTTP and SMTP tarpits. As a former [TurnTide](https://en.wikipedia.org/wiki/TurnTide) employee, I was a little disappointed that he seemed to ignore that approach, but overall it was a fairly good overview. One important point that he brought up was that SMTP tarpit effectiveness is local to the protected network whereas HTTP tarpits can be used to slow down and trap spammers as they attempt to harvest email addresses. The difference here is that one protects you (SMTP tarpits) and the other protects all in a strictly weaker capacity by hindering spammers at the start of the journey (HTTP tarpits).

Phil Raymond from Vanquish then got up and gave what amounted to a sales pitch for his new email reputation system. He tried pretty hard to coin the term "personal interrupt value" in describing how he wanted to create a "fluid market for your moment-by-moment attention". Its not just that I've heard this before, but I've heard it from every email reputation service vendor. Goodmail, Bonded Sender, smtpRM... they all say the same exact things. How are we to differentiate? In case you don't know, the basic idea is that senders put up something of value in bond, and then that bond is debitted should there be a conflict. The twist with Vanquish is that if you decide that you know a person or that you like the email, the sender doesn't pay. That does neatly handle the case of friends and family not having to pay to play, but there are a number of other problems. It hit a couple of my [FUSSP](https://www.rhyolite.com/anti-spam/you-might-be.html) sensors, including requiring (or at least substantially benefitting from) a "flag day", they didn't have a good answer for zombies ("end users will have so little at risk, it won't matter"), etc. Basically, I wasn't impressed. If all these guys got together and standardized something that might move me.

There's another important point about email reputation systems that a lot of people seem to be missing. This trial that Goodmail has going on with AOL and Yahoo!? That's the entire industry's big break. If Goodmail fails to deliver, then BS, smtpRM, Vanquish and any others are going to be set back years, as well. I understand their willingness to get in the game before its truly established, but they're a niche within a niche. A big setback at either AOL or Yahoo! will not incite other ISPs or enterprises to knock down any of their doors. 

As an aside, I have a feeling that no one from AOL or Yahoo! showed up this year in large part because they didn't want the shitstorm from the audience about their decision to go with Goodmail.

The next talk was very cool: the guys from BitDefender talked about using adaptive neural networks for email classification. Specifically, filtering spam, but its uses are more general than that. Basically, they employed the [Adaptive Resonance Theory](https://en.wikipedia.org/wiki/Adaptive_resonance_theory) to a hierarchy of these neural networks and got some pretty promising results. The big thing here is that you don't need to retrain it with the entire corpus; it can learn new heuristics without forgetting the old ones. The heuristics still have to be created by some other means, of course, but this was a pretty interesting technique, nonetheless.

Next, Giovanni Donelli from the [University of Bologna](https://www.unibo.it/it) talked about a technique he called "Email Interferometry". The idea boils down to monitoring a set of related accounts (called an "e-pool") looking for the same spam messages to come into multiple accounts in the pool. He posited that it might not work well on large scales and did not itself indicate a filtering/classification technology. Didn't seem too promising.

Bill Yerazunis talked about sorting spam with k-nearest neighbor and his new Hyperspace classifier in CRM114. I missed the first half of this talk, but I think he used kNN to attempt to match or exceed the quality of Markov chaining. Since I missed the meat of this one, I'm not going to comment further, but you can try it today by telling crm114 to use "hyperspace".

Now, as far as the paper with the biggest potential for impact, I'm going to say it was Kang Li et al's *Towards a Ham Archive*. Anyone who works on anti-spam software knows that we can get spam any time we want, in any quantity. The problem is getting a source of quality ham. There is the SA ham corpus and the TREC corpus, but not much else. This is a problem because without a large, quality source of ham all of our effectiveness statistics are eternally suspect. Li has thought of a method that might work for creating a large public corpus of ham without exposing the actual message data. Simply hash bigrams of the message in a sliding window and insert the digest values into a vector. The vector is then the quantity which is published in a public archive. The cool thing is, statistical filters already work on "tokens", which are currently some number of words from the message. The digests in the digest vector could easily be used in the same capacity. But, since the messages are being digested in bigrams by a sliding window, the original message cannot be reproduced, so users can have confidence in releasing their ham to a public corpus. It wasn't clear how large of a tradeoff there would be between protecting the privacy of the messages' authors and effectiveness of the filters trained using digest vectors, but I think its definitely a well needed advance for a tough problem.

Reflexion then talked about their Supplemental Address Management System, which as far as I can tell, differs little from TitanKey other than the fact that it doesn't employ challenge-response. They have some theory about how their system is better then disposable email addresses, but frankly, I couldn't see a qualitative difference.

Mr. Palla then talked about how to detect phishes in email. I had some high hopes for this talk, because I talked to him and his wife for at least an hour the night before, but he blazed through those slides way too fast. The slides themselves were also far too dense for the time allotted. From what I gather, he was analysing the headers for rDNS information and also checking the recipient's sent folder for matching addresses. Andrew from MessageLabs commented that they were getting better effectiveness from rDNS inspection alone than what Palla reported in his talk. Oh well.

Here's the biggest travesty of the day: we came back just in time for Jon Zdziarski's last slide for his talk about probabilistic digital fingerprinting techniques as applied to phishing detection. That sucked. I really wanted to see this one because his talk from last year was the best by far. Still, I talked to him the night before about it and he told me that it was basically building fingerprints of the pages that are linked to in email messages. The fingerprints were then correllated to find pages that have a large number of fingrprints in common, so that they can distinguish which of those uncommon fingerprints would be replicated across multiple emails. This would then indicate a set of fingerprints for an author of a phish. I may be messing up the details somewhat, so I will redo this section after I read the paper.

Fidelis Assis then phoned in a talk about "Exponential Differential Document Count" from Brazil. It was somewhat hard to understand over the phone over the loudspeaker, but the EDDC technique attempts to replicate what humans do when reading mail by picking out strong features and lessening the importance of ones that occur about equally in both ham and spam. I wrote down that I should get the paper, but it appears to increase effectiveness in CRM114. In the meantime, you can check out the code [here](https://github.com/arunpersaud/osbf-lua) or [here](https://en.wikipedia.org/wiki/CRM114_(program)).

Aaron Kornblum then talked about how Microsoft's team let a PC get infected with a zombie and checked to see what it did. They didn't let any email out from it, but it got a huge number of connection attempts and tried to send a ton of email. They then used that info to file suits against the zombie controllers. Cool stuff.

Jon Praed kept up his streak by talking at this one, this time about CAN-SPAM and some problems it has. Spammers are doing what he calls "microbranding", which is keeping a low enough profile to appear small while still getting enough volume to be profitable. This entails started a bunch of shell companies and not spamming the biggest ISPs. Spammers are also fleeing offshore, but the fact that they are US citizens poses both problems and solutions for the authorities. Jon then indicated that the costs of CAN-SPAM are not known, but that it was basically really good for ensuring the legit mailers comply but not having much of an effect on spammers. He posed an interesting alternative to CAN-SPAM modeled after 18 USC 2257, which is the regulation that says all adult performers need to have their age and info recorded by someone and available upon request (to prevent another Traci Lords). Good talk, as usual.

Keynotes
---------

![](/a/032806_15391.jpg)

Eric Allman, creator of [Sendmail](https://en.wikipedia.org/wiki/Sendmail), gave the first keynote. He was advocating using Sender Domain Authentication (i.e. [DKIM](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail)). Mostly it was an overview, but he indicated that there were definitely some rich research topics to explore in this area and that a lot of work was left to do to work out the IETF standards. Benefits listed were making whitelists more reliable, displaying auth results to user, etc. He concluded that it was a valuable tool for the anti-spam toolkit and that authentication was required to achieve a full ID suite for Internet communications.

![](/a/032806_16201.jpg)

Barry Shein, President and CEO of [The World](https://en.wikipedia.org/wiki/The_World_(Internet_service_provider)), gave the second keynote. It was pretty funny, if a little disconnected. He talked about [all of this stuff](https://www.theworld.com/~bzs/spamconf2006.html).

Overall, a very good conference and I was glad I decided to go again this year, especially after [last year's debacle](/blog/2005/01/23/mit-spam-conference-2005). I plan on attending again next year.
