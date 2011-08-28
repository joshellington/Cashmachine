BRANCH=$(shell git status|grep "On branch" | cut -f4 -d" ")

default:
	@echo $(BRANCH)

pull:
	 rsync --exclude-from=rsync.exclude -rcv dev@rhapi.com:/var/www/ ./

fakepull:
	 rsync --exclude-from=rsync.exclude -rcvn dev@rhapi.com:/var/www/./

push:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv ./ dev@rhapi.com:/var/www/
else
	 @echo "Push must be done from master foo!"
endif

push_delete:
ifeq ($(BRANCH),master)
	 rsync --exclude-from=rsync.exclude -rcv --delete ./ dev@rhapi.com:/var/www/
else
	 @echo "Push must be done from master foo!"
endif

fakepush:
	rsync --exclude-from=rsync.exclude -rcvn ./ dev@rhapi.com:/var/www/

fakepush_delete:
	rsync --exclude-from=rsync.exclude -rcvn --delete ./ dev@rhapi.com:/var/www/

stagepull:
	 rsync --exclude-from=rsync.exclude -rcv dev@rhapi.com:/var/www/ ./

stagefakepull:
	 rsync --exclude-from=rsync.exclude -rcvn dev@rhapi.com:/var/www/./

stagepush:
ifeq ($(BRANCH),stage)
	 rsync --exclude-from=rsync.exclude -rcv ./ dev@rhapi.com:/var/www/
else
	 @echo "Push must be done from stage foo!"
endif

stagepush_delete:
ifeq ($(BRANCH),stage)
	 rsync --exclude-from=rsync.exclude -rcv --delete ./ dev@rhapi.com:/var/www/
else
	 @echo "Push must be done from stage foo!"
endif

stagefakepush:
	rsync --exclude-from=rsync.exclude -rcvn ./ dev@rhapi.com:/var/www/

stagefakepush_delete:
	rsync --exclude-from=rsync.exclude -rcvn --delete ./ dev@rhapi.com:/var/www/