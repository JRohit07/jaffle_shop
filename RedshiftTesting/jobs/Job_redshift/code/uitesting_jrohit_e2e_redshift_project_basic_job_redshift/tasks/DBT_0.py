def DBT_0():
    from datetime import timedelta
    from airflow.operators.bash import BashOperator

    return BashOperator(
        task_id = "DBT_0",
        bash_command = "set -euxo pipefail; tmpDir=`mktemp -d`; git clone https://github.com/JRohit07/jaffle_shop --branch br1 --single-branch $tmpDir; cd $tmpDir/RedshiftTesting; dbt run --profile run_profile_redshift; dbt test --profile run_profile_redshift; ",
        env = {"DBT_PROFILES_DIR" : "/usr/local/airflow/dags"},
        append_env = True,
    )
