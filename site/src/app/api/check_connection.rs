use super::*;

pub mod exports {
    pub use super::check_connection;
}

#[server]
pub async fn check_connection() -> Result<(), ServerFnError> {
    println!("Checking connection to database...");
    database::db_conn();
    println!("OK");

    Ok(())
}
