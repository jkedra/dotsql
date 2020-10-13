col directory_path format a40
col directory_name format A22
col owner FORMAT A20
SELECT owner,directory_name,directory_path
    FROM all_directories;

