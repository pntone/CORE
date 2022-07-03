CREATE UNIQUE INDEX "CORE"."UQ_LOGS_BLACKLIST" ON "CORE"."LOGS_BLACKLIST" ("APP_ID", "USER_ID", "PAGE_ID", "FLAG", "MODULE_LIKE", "ACTION_LIKE")
  TABLESPACE "DATA"
/
