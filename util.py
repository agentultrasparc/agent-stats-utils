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


