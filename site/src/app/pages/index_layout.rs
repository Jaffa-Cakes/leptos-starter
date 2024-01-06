use super::*;

pub mod index;
pub mod machines;

pub use index::Index;
pub use machines::Machines;

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
