interface ExampleComponentProps {
	title: string;
	isActive: boolean;
	blocks: string[];
}
const ComponentName = (props: ExampleComponentProps) => {
	return (
		<div>
			<h1>{props.title}</h1>
			<h2 className="flex">{"Heading 2"}</h2>
			{props.blocks.map((block, idx) => (
				<li key={`key-${idx}`}>{block ?? "Hello" + "yank"}</li>
			))}
		</div>
	);
};

export default ExampleComponent
