interface ExampleComponentProps {
	title: string;
	isActive: boolean;
	blocks: string[];
}
const ExampleComponent = (props: ExampleComponentProps) => {
	return (
		<div>
			<h1>{props.title}</h1>
			{props.blocks.map((block, idx) => (
				<li key={`${idx.toString()}`}>{block}</li>
			))}
		</div>
	);
};

export default ExampleComponent;
