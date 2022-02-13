--DROP TABLE mail_queue PURGE;
CREATE TABLE mail_queue (
    queue_id            NUMBER(10)      CONSTRAINT nn_mail_queue_queue_id       NOT NULL,
    app_id              NUMBER(4)       CONSTRAINT nn_mail_queue_app_id         NOT NULL,
    event_id            VARCHAR2(30),
    role_id             VARCHAR2(30),
    template_id         VARCHAR2(30),
    schedule_id         VARCHAR2(30),
    user_id             VARCHAR2(30),
    lang_id             VARCHAR2(5),
    --
    mail_recipient      VARCHAR2(4000),     -- mail headers
    mail_cc             VARCHAR2(4000),
    mail_bcc            VARCHAR2(4000),
    mail_sender         VARCHAR2(256),
    mail_subject        VARCHAR2(256),
    mail_body           CLOB,               -- mail body
    --
    -- @TODO: mail_attachments
    --
    created_by          VARCHAR2(30),
    created_at          DATE,
    sent_at             DATE,
    --
    CONSTRAINT pk_mail_queue
        PRIMARY KEY (queue_id),
    --
    CONSTRAINT fk_mail_queue_app_id
        FOREIGN KEY (app_id)
        REFERENCES apps (app_id),
    --
    CONSTRAINT fk_mail_queue_user_roles
        FOREIGN KEY (app_id, user_id, role_id)
        REFERENCES user_roles (app_id, user_id, role_id),
    --
    CONSTRAINT fk_mail_queue_subscriptions
        FOREIGN KEY (app_id, event_id, role_id, schedule_id)
        REFERENCES mail_subscriptions (app_id, event_id, role_id, schedule_id)
);
--
COMMENT ON TABLE  mail_queue                    IS '[CORE] Queue with e-mails to track what was sent and when';
--
COMMENT ON COLUMN mail_queue.queue_id           IS 'Unique ID from queue_id sequence';
COMMENT ON COLUMN mail_queue.app_id             IS 'APEX application ID';
COMMENT ON COLUMN mail_queue.event_id           IS '';
COMMENT ON COLUMN mail_queue.role_id            IS '';
COMMENT ON COLUMN mail_queue.template_id        IS '';
COMMENT ON COLUMN mail_queue.schedule_id        IS 'Schedule id';
COMMENT ON COLUMN mail_queue.user_id            IS '';
COMMENT ON COLUMN mail_queue.lang_id            IS '';
--
COMMENT ON COLUMN mail_queue.mail_recipient     IS '';
COMMENT ON COLUMN mail_queue.mail_cc            IS '';
COMMENT ON COLUMN mail_queue.mail_bcc           IS '';
COMMENT ON COLUMN mail_queue.mail_sender        IS '';
COMMENT ON COLUMN mail_queue.mail_subject       IS 'E-mail subject';
COMMENT ON COLUMN mail_queue.mail_body          IS 'E-mail body, can be generated by a process_function';
--
COMMENT ON COLUMN mail_queue.created_by         IS 'User whi created the e-mail';
COMMENT ON COLUMN mail_queue.created_at         IS 'Time of adding e-mail to the queue';
COMMENT ON COLUMN mail_queue.sent_at            IS 'Time when e-mail was actually sent';

