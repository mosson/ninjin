ninjin
======

This is an application for backup, viewing, and issuing Error Logs.
If you need more information about rake tasks, run `rake -T "taskname"`


## Settings

```
$ bundle install
```
Set values in config/conf.yaml for Extract_Error_Log

```
environment: "environment_name"
  path: "path_to_environment"
  user: "user_name"
  password: "password_for_ssh_connecting"
```

Environment Value

```
PATH_TO_LOGS="path"
# set value from root to logs on remote machine.
```



Start Server

```
$ rake server:start
```

## Usage

Start backing up logs

```
$ rake backup:launch
```

Backup logs from remote machine.

```
$ rake backup:remote:retrieve
```

Export report

```
$ rake backup:remote:report
```

Migration

```
$ rake db:migrate
```
Export CSV files for seed

```
$ rake db:seed:generate
```
Seed

```
$ rake db:seed
```



## Dependencies



