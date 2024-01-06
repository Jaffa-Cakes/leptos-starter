use super::*;

#[component]
pub fn Index() -> impl IntoView {
    view! {
        <div class="min-h-full min-w-full p-2 flex justify">
            <div class="flex flex-col justify-center items-center">
                <h1 class="text-4xl font-bold">"Hello from the index page!!"</h1>
                <A href="/another-page">"Go to another page"</A>
            </div>
        </div>
    }
}
