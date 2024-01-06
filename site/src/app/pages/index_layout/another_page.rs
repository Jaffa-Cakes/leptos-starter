use super::*;

#[component]
pub fn AnotherPage() -> impl IntoView {
    view! {
        <h1>"Hello from another page!!"</h1>
        <A href="/">"Go back"</A>
    }
}
