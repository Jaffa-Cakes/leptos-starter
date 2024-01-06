use super::*;

#[component]
pub fn Index() -> impl IntoView {
    view! {
        <div class="min-h-full min-w-full p-2">
            <div class="flex flex-col items-center justify-center h-full">
                <h1 class="text-4xl font-bold">"Welcome to Panel!!!"</h1>
                <div class="text-2xl">"This is the index page."</div>

                <div class="text-2xl mt-5">
                    "<--- Select another page from the navbar!"
                </div>
            </div>
        </div>
    }
}
