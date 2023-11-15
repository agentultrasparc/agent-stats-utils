def create_code(new_stats):
    templates = {
        'util.py > check_schema': "  ADD COLUMN `{statname}` BIGINT unsigned DEFAULT NULL,\n",
        'Stat.py > fields': ", {statnodash}",
        'Stat.py > db_load()': "        self.{statnodash} = row.{statnodash}\n",
        'Stat.py > table_load()': "        self.{statnodash} = row.get('{statname}', 0)\n",
        'Stat.py > save(1)': "                     {statbacktick},\n",
        'Stat.py > save(2)': "                     :{statbacktick},\n",
        'Stat.py > save(3)': "                     {statbacktick}=:{statbacktick}',\n",
        'agent_stats.py > get_stats() > definitions': "                   '{statname}': '({description})',\n",
        'agent_stats.py > get_badges() > categories (or 3 tier categories) (skip if not officialy badged stat)': "                  '{statname}': [{tiers}],\n",
        'agent_stats.py > summary() > headers (skip if not officialy badged stat)': "               '{statnodash}',\n",
        'agent_stats.py > summary() > sql_before & sql_after (skip if not officialy badged stat)': ", {statname}",
        'templates': "{{{{ high_scores(chart{stattemplate}) -}}}}\n"}
    for place, template in templates.items():
        print(place + ':')
        for stat, description, tiers in new_stats:
            stat_dict = {'description': description,
                         'tiers': ', '.join([tier.strip().replace(',', '') for tier in tiers.split('\t')[1:] if tier != 'N/A']),
                         'statname': stat,
                         'statnodash': stat.replace('-', '_'),
                         'statbacktick': f'`{stat}`' if '-' in stat else stat,
                         'stattemplate': f"['{stat}']" if '-' in stat else f'.{stat}',
                        }
            print(template.format(**stat_dict), end='')
        print('\n')


#https://www.agent-stats.com/faq.php
#copy the new stat(s) from the table and paste them here as is

a = '''overclocker
Overclock Hack Points
	750	1,250	2,250	5,500	7,500'''

it = iter(a.split('\n'))

create_code(list(zip(it, it, it)))
