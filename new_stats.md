*READ ALL OF THIS!* There's important stuff at the end.

# Adding new stats

* use new_stat_helper.py
* in util.py
  - add a column in stats table for fresh database creations
  - bump meta table schema version
  - add code to check for version less than new version and add column
* update string: fields (change - to _)
  - db_load()
  - table_load()
  - save() x2
* in agent_stats.py:
  - update definitions
  - `categories` dict (in `get_badges()`) # only if real badged stat is being added
  - `headers` tuple (in `summary()`) use _ here # only if real badged stat is being added
       `sql_before` & `sql_now` # only if real badged stat is being added
* add new stat to template(s)
* commit and push to github
* deploy on remotes
  - `git fetch --all && git reset --hard origin/master`
* transfer custom templates manually

# to remove a dead stat
* in Stat.py:
  - remove from `table_load()`
  - remove from `save()` in both places
* in agent_stats.py:
  - remove from `get_stats()` > definitions
  - mark # obsolete in `summary()` > headers if was official tiered stat
