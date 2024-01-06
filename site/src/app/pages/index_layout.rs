use super::*;

pub mod another_page;
pub mod index;

pub use another_page::AnotherPage;
pub use index::Index;

#[component]
pub fn IndexLayout() -> impl IntoView {
    view! {
        <div class="flex flex-row min-h-screen">
            <main class="flex flex-col flex-grow">
                <Outlet />
            </main>
        </div>
    }
}
