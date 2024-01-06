use super::*;

#[component]
pub fn AnotherPage() -> impl IntoView {
    let _ = create_local_resource(
        || (),
        |_| async move { api::check_connection().await.unwrap() },
    );

    view! {
        <h1>"Hello from another page!!"</h1>
        <A href="/">"Go back"</A>
    }
}
