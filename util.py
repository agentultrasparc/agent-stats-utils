from mail import mail
import sqlite3
import logging

# import warnings

class CM(object):
    ''' connection manager '''
    def __init__(self):
        self.connection = None

    def set_config(self, config):
        self.config = config
        self.close()

    def get_conn(self):
        if not self.connection:
            logging.info('no db connection. creating...')
            self.connection = con = sqlite3.connect(self.config['db'])
        return self.connection

    def close(self):
        if self.connection:
            self.connection.close()
            self.connection = None

cm = CM()

def exec_sql(sql, args={}):
    try:
        cur = None # needed in case get_conn() dies
        db = cm.get_conn()
        cur = db.cursor()
        cur.execute(sql, args)
        rows = [r for r in cur.fetchall()]
        if not rows and not sql.strip().lower().startswith('select'):
            rows = cur.rowcount
        cur.close()
        db.commit()
        return rows

    except:
        logging.error(sql)
        raise

def check_schema():
    meta = exec_sql("SELECT name FROM sqlite_master WHERE type='table' AND name='meta';")
    if not meta:  # implied version 1, upgrade to 2
         db = cm.get_conn()
         db.execute("CREATE TABLE `meta` (`schemaver` INTEGER NOT NULL);");
         db.execute("INSERT INTO `meta` VALUES ( 2 );");

    ver = exec_sql("SELECT `schemaver` from `meta`;");
    ver = ver[0][0];
    logging.info(f'schema version {ver}');

    if ver < 3:
        db = cm.get_conn()
        db.executescript("""
           ALTER TABLE `stats`
           ADD COLUMN `eos_imprint` BIGINT unsigned DEFAULT NULL;
           UPDATE meta SET schemaver=3;
        """);
        ver = 3;
        logging.info(f'schema version updated to {ver}');

    # upgrade schema here

