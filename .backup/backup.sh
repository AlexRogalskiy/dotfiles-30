# sudo docker run -p 9000:9000 --name minio1 \
#   -e "MINIO_ACCESS_KEY="" \
#   -e "MINIO_SECRET_KEY="" \
#   -v /media/misc/backups/data:/data \
#   -v /media/misc/backups/config:/root/.minio \
#   minio/minio server /data

# restic -r s3:https://rjhome.icu:9000/`whoami`-`hostname` init

export RESTIC_PASSWORD_FILE="/var/backup/restic_password"
export AWS_ACCESS_KEY_ID=`cat /var/backup/restic_id`
export AWS_SECRET_ACCESS_KEY=`cat /var/backup/restic_access_key`
backup_command="`which restic` -r s3:https://rjhome.icu:9000/`whoami`-`hostname` backup $HOME --exclude-caches --exclude-if-present .nobackup --exclude-if-present .restic-ignore --exclude-file=restic_ignore"
exec $backup_command